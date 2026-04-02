#include "StdAfx.h"
#include "CeSQLite.h"

static const bool DONT_DELETE_MSG=false;

CCeSQLiteException::CCeSQLiteException(const int nErrCode,
									char* szErrMess,
									bool bDeleteMsg/*=true*/) :
									mnErrCode(nErrCode)
{
	mpszErrMess = sqlite3_mprintf("%s[%d]: %s",
								errorCodeAsString(nErrCode),
								nErrCode,
								szErrMess ? szErrMess : "");

	if (bDeleteMsg && szErrMess)
	{
		sqlite3_free(szErrMess);
	}
}

									
CCeSQLiteException::CCeSQLiteException(const CCeSQLiteException&  e) :
									mnErrCode(e.mnErrCode)
{
	mpszErrMess = 0;
	if (e.mpszErrMess)
	{
		mpszErrMess = sqlite3_mprintf("%s", e.mpszErrMess);
	}
}


const char* CCeSQLiteException::errorCodeAsString(int nErrCode)
{
	switch (nErrCode)
	{
		case SQLITE_OK          : return "SQLITE_OK";
		case SQLITE_ERROR       : return "SQLITE_ERROR";
		case SQLITE_INTERNAL    : return "SQLITE_INTERNAL";
		case SQLITE_PERM        : return "SQLITE_PERM";
		case SQLITE_ABORT       : return "SQLITE_ABORT";
		case SQLITE_BUSY        : return "SQLITE_BUSY";
		case SQLITE_LOCKED      : return "SQLITE_LOCKED";
		case SQLITE_NOMEM       : return "SQLITE_NOMEM";
		case SQLITE_READONLY    : return "SQLITE_READONLY";
		case SQLITE_INTERRUPT   : return "SQLITE_INTERRUPT";
		case SQLITE_IOERR       : return "SQLITE_IOERR";
		case SQLITE_CORRUPT     : return "SQLITE_CORRUPT";
		case SQLITE_NOTFOUND    : return "SQLITE_NOTFOUND";
		case SQLITE_FULL        : return "SQLITE_FULL";
		case SQLITE_CANTOPEN    : return "SQLITE_CANTOPEN";
		case SQLITE_PROTOCOL    : return "SQLITE_PROTOCOL";
		case SQLITE_EMPTY       : return "SQLITE_EMPTY";
		case SQLITE_SCHEMA      : return "SQLITE_SCHEMA";
		case SQLITE_TOOBIG      : return "SQLITE_TOOBIG";
		case SQLITE_CONSTRAINT  : return "SQLITE_CONSTRAINT";
		case SQLITE_MISMATCH    : return "SQLITE_MISMATCH";
		case SQLITE_MISUSE      : return "SQLITE_MISUSE";
		case SQLITE_NOLFS       : return "SQLITE_NOLFS";
		case SQLITE_AUTH        : return "SQLITE_AUTH";
		case SQLITE_FORMAT      : return "SQLITE_FORMAT";
		case SQLITE_RANGE       : return "SQLITE_RANGE";
		case SQLITE_ROW         : return "SQLITE_ROW";
		case SQLITE_DONE        : return "SQLITE_DONE";
		case CCESQLITE_ERROR    : return "CCESQLITE_ERROR";
		default: return "UNKNOWN_ERROR";
	}
}

CCeSQLiteException::~CCeSQLiteException()
{
	if (mpszErrMess)
	{
		sqlite3_free(mpszErrMess);
		mpszErrMess = 0;
	}
}

////////////////////////////////////////////////////////////////////////////////

CCeSQLiteQuery::CCeSQLiteQuery()
{
	mpVM = 0;
	mbEof = true;
	mnCols = 0;
	mbOwnVM = false;
}


CCeSQLiteQuery::CCeSQLiteQuery(const CCeSQLiteQuery& rQuery)
{
	mpVM = rQuery.mpVM;
	// Only one object can own the VM
	const_cast<CCeSQLiteQuery&>(rQuery).mpVM = 0;
	mbEof = rQuery.mbEof;
	mnCols = rQuery.mnCols;
	mbOwnVM = rQuery.mbOwnVM;
}


CCeSQLiteQuery::CCeSQLiteQuery(sqlite3* pDB,
							sqlite3_stmt* pVM,
							bool bEof,
							bool bOwnVM/*=true*/)
{
	mpDB = pDB;
	mpVM = pVM;
	mbEof = bEof;
	mnCols = sqlite3_column_count(mpVM);
	mbOwnVM = bOwnVM;
}


CCeSQLiteQuery::~CCeSQLiteQuery()
{
	try
	{
		finalize();
	}
	catch (...)
	{
	}
}


CCeSQLiteQuery& CCeSQLiteQuery::operator=(const CCeSQLiteQuery& rQuery)
{
	try
	{
		finalize();
	}
	catch (...)
	{
	}
	mpVM = rQuery.mpVM;
	// Only one object can own the VM
	const_cast<CCeSQLiteQuery&>(rQuery).mpVM = 0;
	mbEof = rQuery.mbEof;
	mnCols = rQuery.mnCols;
	mbOwnVM = rQuery.mbOwnVM;
	return *this;
}


int CCeSQLiteQuery::numFields()
{
	checkVM();
	return mnCols;
}


const char* CCeSQLiteQuery::fieldValue(int nField)
{
	checkVM();

	if (nField < 0 || nField > mnCols-1)
	{
		throw CCeSQLiteException(CCESQLITE_ERROR,
								"Invalid field index requested",
								DONT_DELETE_MSG);
	}

	return (const char*)sqlite3_column_text(mpVM, nField);
}


const char* CCeSQLiteQuery::fieldValue(const char* szField)
{
	int nField = fieldIndex(szField);
	return (const char*)sqlite3_column_text(mpVM, nField);
}


int CCeSQLiteQuery::getIntField(int nField, int nNullValue/*=0*/)
{
	if (fieldDataType(nField) == SQLITE_NULL)
	{
		return nNullValue;
	}
	else
	{
		return sqlite3_column_int(mpVM, nField);
	}
}


int CCeSQLiteQuery::getIntField(const char* szField, int nNullValue/*=0*/)
{
	int nField = fieldIndex(szField);
	return getIntField(nField, nNullValue);
}


sqlite_int64 CCeSQLiteQuery::getInt64Field(int nField, sqlite_int64 nNullValue/*=0*/)
{
	if (fieldDataType(nField) == SQLITE_NULL)
	{
		return nNullValue;
	}
	else
	{
		return sqlite3_column_int64(mpVM, nField);
	}
}


sqlite_int64 CCeSQLiteQuery::getInt64Field(const char* szField, sqlite_int64 nNullValue/*=0*/)
{
	int nField = fieldIndex(szField);
	return getInt64Field(nField, nNullValue);
}


double CCeSQLiteQuery::getFloatField(int nField, double fNullValue/*=0.0*/)
{
	if (fieldDataType(nField) == SQLITE_NULL)
	{
		return fNullValue;
	}
	else
	{
		return sqlite3_column_double(mpVM, nField);
	}
}


double CCeSQLiteQuery::getFloatField(const char* szField, double fNullValue/*=0.0*/)
{
	int nField = fieldIndex(szField);
	return getFloatField(nField, fNullValue);
}


const char* CCeSQLiteQuery::getStringField(int nField, const char* szNullValue/*=""*/)
{
	if (fieldDataType(nField) == SQLITE_NULL)
	{
		return szNullValue;
	}
	else
	{
		return (const char*)sqlite3_column_text(mpVM, nField);
	}
}


const char* CCeSQLiteQuery::getStringField(const char* szField, const char* szNullValue/*=""*/)
{
	int nField = fieldIndex(szField);
	return getStringField(nField, szNullValue);
}


const unsigned char* CCeSQLiteQuery::getBlobField(int nField, int& nLen)
{
	checkVM();

	if (nField < 0 || nField > mnCols-1)
	{
		throw CCeSQLiteException(CCESQLITE_ERROR,
								"Invalid field index requested",
								DONT_DELETE_MSG);
	}

	nLen = sqlite3_column_bytes(mpVM, nField);
	return (const unsigned char*)sqlite3_column_blob(mpVM, nField);
}


const unsigned char* CCeSQLiteQuery::getBlobField(const char* szField, int& nLen)
{
	int nField = fieldIndex(szField);
	return getBlobField(nField, nLen);
}


bool CCeSQLiteQuery::fieldIsNull(int nField)
{
	return (fieldDataType(nField) == SQLITE_NULL);
}


bool CCeSQLiteQuery::fieldIsNull(const char* szField)
{
	int nField = fieldIndex(szField);
	return (fieldDataType(nField) == SQLITE_NULL);
}


int CCeSQLiteQuery::fieldIndex(const char* szField)
{
	checkVM();

	if (szField)
	{
		for (int nField = 0; nField < mnCols; nField++)
		{
			const char* szTemp = sqlite3_column_name(mpVM, nField);

			if (strcmp(szField, szTemp) == 0)
			{
				return nField;
			}
		}
	}

	throw CCeSQLiteException(CCESQLITE_ERROR,
							"Invalid field name requested",
							DONT_DELETE_MSG);
}


const char* CCeSQLiteQuery::fieldName(int nCol)
{
	checkVM();

	if (nCol < 0 || nCol > mnCols-1)
	{
		throw CCeSQLiteException(CCESQLITE_ERROR,
								"Invalid field index requested",
								DONT_DELETE_MSG);
	}

	return sqlite3_column_name(mpVM, nCol);
}


const char* CCeSQLiteQuery::fieldDeclType(int nCol)
{
	checkVM();

	if (nCol < 0 || nCol > mnCols-1)
	{
		throw CCeSQLiteException(CCESQLITE_ERROR,
								"Invalid field index requested",
								DONT_DELETE_MSG);
	}

	return sqlite3_column_decltype(mpVM, nCol);
}


int CCeSQLiteQuery::fieldDataType(int nCol)
{
	checkVM();

	if (nCol < 0 || nCol > mnCols-1)
	{
		throw CCeSQLiteException(CCESQLITE_ERROR,
								"Invalid field index requested",
								DONT_DELETE_MSG);
	}

	return sqlite3_column_type(mpVM, nCol);
}


bool CCeSQLiteQuery::eof()
{
	checkVM();
	return mbEof;
}


void CCeSQLiteQuery::nextRow()
{
	checkVM();

	int nRet = sqlite3_step(mpVM);

	if (nRet == SQLITE_DONE)
	{
		// no rows
		mbEof = true;
	}
	else if (nRet == SQLITE_ROW)
	{
		// more rows, nothing to do
	}
	else
	{
		nRet = sqlite3_finalize(mpVM);
		mpVM = 0;
		const char* szError = sqlite3_errmsg(mpDB);
		throw CCeSQLiteException(nRet,
								(char*)szError,
								DONT_DELETE_MSG);
	}
}


void CCeSQLiteQuery::finalize()
{
	if (mpVM && mbOwnVM)
	{
		int nRet = sqlite3_finalize(mpVM);
		mpVM = 0;
		if (nRet != SQLITE_OK)
		{
			const char* szError = sqlite3_errmsg(mpDB);
			throw CCeSQLiteException(nRet, (char*)szError, DONT_DELETE_MSG);
		}
	}
}


void CCeSQLiteQuery::checkVM()
{
	if (mpVM == 0)
	{
		throw CCeSQLiteException(CCESQLITE_ERROR,
								"Null Virtual Machine pointer",
								DONT_DELETE_MSG);
	}
}

////////////////////////////////////////////////////////////////////////////////

CCeSQLiteTable::CCeSQLiteTable()
{
	mpaszResults = 0;
	mnRows = 0;
	mnCols = 0;
	mnCurrentRow = 0;
}


CCeSQLiteTable::CCeSQLiteTable(const CCeSQLiteTable& rTable)
{
	mpaszResults = rTable.mpaszResults;
	// Only one object can own the results
	const_cast<CCeSQLiteTable&>(rTable).mpaszResults = 0;
	mnRows = rTable.mnRows;
	mnCols = rTable.mnCols;
	mnCurrentRow = rTable.mnCurrentRow;
}


CCeSQLiteTable::CCeSQLiteTable(char** paszResults, int nRows, int nCols)
{
	mpaszResults = paszResults;
	mnRows = nRows;
	mnCols = nCols;
	mnCurrentRow = 0;
}


CCeSQLiteTable::~CCeSQLiteTable()
{
	try
	{
		finalize();
	}
	catch (...)
	{
	}
}


CCeSQLiteTable& CCeSQLiteTable::operator=(const CCeSQLiteTable& rTable)
{
	try
	{
		finalize();
	}
	catch (...)
	{
	}
	mpaszResults = rTable.mpaszResults;
	// Only one object can own the results
	const_cast<CCeSQLiteTable&>(rTable).mpaszResults = 0;
	mnRows = rTable.mnRows;
	mnCols = rTable.mnCols;
	mnCurrentRow = rTable.mnCurrentRow;
	return *this;
}


void CCeSQLiteTable::finalize()
{
	if (mpaszResults)
	{
		sqlite3_free_table(mpaszResults);
		mpaszResults = 0;
	}
}


int CCeSQLiteTable::numFields()
{
	checkResults();
	return mnCols;
}


int CCeSQLiteTable::numRows()
{
	checkResults();
	return mnRows;
}


const char* CCeSQLiteTable::fieldValue(int nField)
{
	checkResults();

	if (nField < 0 || nField > mnCols-1)
	{
		throw CCeSQLiteException(CCESQLITE_ERROR,
								"Invalid field index requested",
								DONT_DELETE_MSG);
	}

	int nIndex = (mnCurrentRow*mnCols) + mnCols + nField;
	return mpaszResults[nIndex];
}


const char* CCeSQLiteTable::fieldValue(const char* szField)
{
	checkResults();

	if (szField)
	{
		for (int nField = 0; nField < mnCols; nField++)
		{
			if (strcmp(szField, mpaszResults[nField]) == 0)
			{
				int nIndex = (mnCurrentRow*mnCols) + mnCols + nField;
				return mpaszResults[nIndex];
			}
		}
	}

	throw CCeSQLiteException(CCESQLITE_ERROR,
							"Invalid field name requested",
							DONT_DELETE_MSG);
}


int CCeSQLiteTable::getIntField(int nField, int nNullValue/*=0*/)
{
	if (fieldIsNull(nField))
	{
		return nNullValue;
	}
	else
	{
		return atoi(fieldValue(nField));
	}
}


int CCeSQLiteTable::getIntField(const char* szField, int nNullValue/*=0*/)
{
	if (fieldIsNull(szField))
	{
		return nNullValue;
	}
	else
	{
		return atoi(fieldValue(szField));
	}
}


double CCeSQLiteTable::getFloatField(int nField, double fNullValue/*=0.0*/)
{
	if (fieldIsNull(nField))
	{
		return fNullValue;
	}
	else
	{
		return atof(fieldValue(nField));
	}
}


double CCeSQLiteTable::getFloatField(const char* szField, double fNullValue/*=0.0*/)
{
	if (fieldIsNull(szField))
	{
		return fNullValue;
	}
	else
	{
		return atof(fieldValue(szField));
	}
}


const char* CCeSQLiteTable::getStringField(int nField, const char* szNullValue/*=""*/)
{
	if (fieldIsNull(nField))
	{
		return szNullValue;
	}
	else
	{
		return fieldValue(nField);
	}
}


const char* CCeSQLiteTable::getStringField(const char* szField, const char* szNullValue/*=""*/)
{
	if (fieldIsNull(szField))
	{
		return szNullValue;
	}
	else
	{
		return fieldValue(szField);
	}
}

CString CCeSQLiteTable::getCStringField(int nField)
{
	CString strRet;
	char	mb[1024];
	TCHAR	wc[2048];

	if (fieldIsNull(nField))
	{
		return strRet;
	}
	else
	{
		sprintf( mb, "%s", fieldValue(nField) );
		MultiByteToWideChar( CP_ACP , 0, mb, -1, wc, 1024);

		strRet.Format(_T("%s"), wc);

		return strRet;
	}
}


CString CCeSQLiteTable::getCStringField(const char* szField/*=""*/)
{
	CString strRet;
	char	mb[1024];
	TCHAR	wc[2048];

	if (fieldIsNull(szField))
	{
		return strRet;
	}
	else
	{
		sprintf( mb, "%s", fieldValue(szField) );
		MultiByteToWideChar( CP_ACP , 0, mb, -1, wc, 1024);

		strRet.Format(_T("%s"), wc);

		return strRet;
	}
}

bool CCeSQLiteTable::fieldIsNull(int nField)
{
	checkResults();
	return (fieldValue(nField) == 0);
}


bool CCeSQLiteTable::fieldIsNull(const char* szField)
{
	checkResults();
	return (fieldValue(szField) == 0);
}


const char* CCeSQLiteTable::fieldName(int nCol)
{
	checkResults();

	if (nCol < 0 || nCol > mnCols-1)
	{
		throw CCeSQLiteException(CCESQLITE_ERROR,
								"Invalid field index requested",
								DONT_DELETE_MSG);
	}

	return mpaszResults[nCol];
}


void CCeSQLiteTable::setRow(int nRow)
{
	checkResults();

	if (nRow < 0 || nRow > mnRows-1)
	{
		throw CCeSQLiteException(CCESQLITE_ERROR,
								"Invalid row index requested",
								DONT_DELETE_MSG);
	}

	mnCurrentRow = nRow;
}


void CCeSQLiteTable::checkResults()
{
	if (mpaszResults == 0)
	{
		throw CCeSQLiteException(CCESQLITE_ERROR,
								"Null Results pointer",
								DONT_DELETE_MSG);
	}
}


////////////////////////////////////////////////////////////////////////////////


CCeSQLiteDB::CCeSQLiteDB()
{
	mpDB = 0;
	mnBusyTimeoutMs = 60000; // 60 seconds
}


CCeSQLiteDB::CCeSQLiteDB(const CCeSQLiteDB& db)
{
	mpDB = db.mpDB;
	mnBusyTimeoutMs = 60000; // 60 seconds
}


CCeSQLiteDB::~CCeSQLiteDB()
{
	try
	{
		close();
	}
	catch (...)
	{
	}
}


CCeSQLiteDB& CCeSQLiteDB::operator=(const CCeSQLiteDB& db)
{
	mpDB = db.mpDB;
	mnBusyTimeoutMs = 60000; // 60 seconds
	return *this;
}


void CCeSQLiteDB::open(const char* szFile)
{
	int nRet = sqlite3_open(szFile, &mpDB);

	if (nRet != SQLITE_OK)
	{
		const char* szError = sqlite3_errmsg(mpDB);
		throw CCeSQLiteException(nRet, (char*)szError, DONT_DELETE_MSG);
	}

	//setBusyTimeout(mnBusyTimeoutMs);
}


void CCeSQLiteDB::close()
{
	if (mpDB)
	{
		if (sqlite3_close(mpDB) == SQLITE_OK)
		{
			mpDB = 0;
		}
		else
		{
			throw CCeSQLiteException(CCESQLITE_ERROR,
									"Unable to close database",
									DONT_DELETE_MSG);
		}
	}
}

CCeSQLiteQuery CCeSQLiteDB::execQuery(const char* szSQL)
{
	checkDB();

	sqlite3_stmt* pVM = compile(szSQL);

	int nRet = sqlite3_step(pVM);

	if (nRet == SQLITE_DONE)
	{
		// no rows
		return CCeSQLiteQuery(mpDB, pVM, true/*eof*/);
	}
	else if (nRet == SQLITE_ROW)
	{
		// at least 1 row
		return CCeSQLiteQuery(mpDB, pVM, false/*eof*/);
	}
	else
	{
		nRet = sqlite3_finalize(pVM);
		const char* szError= sqlite3_errmsg(mpDB);
		throw CCeSQLiteException(nRet, (char*)szError, DONT_DELETE_MSG);
	}
}

CCeSQLiteTable CCeSQLiteDB::getTable(const char* szSQL)
{
	checkDB();

	char* szError=0;
	char** paszResults=0;
	int nRet;
	int nRows(0);
	int nCols(0);

	nRet = sqlite3_get_table(mpDB, szSQL, &paszResults, &nRows, &nCols, &szError);

	if (nRet == SQLITE_OK)
	{
		return CCeSQLiteTable(paszResults, nRows, nCols);
	}
	else
	{
		return CCeSQLiteTable(NULL, 0, 0);
		//throw CCeSQLiteException(nRet, szError);
	}
}

void CCeSQLiteDB::checkDB()
{
	if (!mpDB)
	{
		throw CCeSQLiteException(CCESQLITE_ERROR,
								"Database not open",
								DONT_DELETE_MSG);
	}
}


sqlite3_stmt* CCeSQLiteDB::compile(const char* szSQL)
{
	checkDB();

	const char* szTail=0;
	sqlite3_stmt* pVM;

	int nRet = sqlite3_prepare(mpDB, szSQL, -1, &pVM, &szTail);

	if (nRet != SQLITE_OK)
	{
		const char* szError = sqlite3_errmsg(mpDB);
		throw CCeSQLiteException(nRet,
								(char*)szError,
								DONT_DELETE_MSG);
	}

	return pVM;
}