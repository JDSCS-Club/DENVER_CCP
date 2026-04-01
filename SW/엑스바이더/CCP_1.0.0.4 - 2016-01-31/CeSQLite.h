#pragma once

#include "sqlite3.h"

#define CCESQLITE_ERROR 1000

class CCeSQLiteException
{
public:

    CCeSQLiteException(const int nErrCode,
                    char* szErrMess,
                    bool bDeleteMsg=true);

    CCeSQLiteException(const CCeSQLiteException&  e);

    virtual ~CCeSQLiteException();

    const int errorCode() { return mnErrCode; }

    const char* errorMessage() { return mpszErrMess; }

    static const char* errorCodeAsString(int nErrCode);

private:

    int mnErrCode;
    char* mpszErrMess;
};

class CCeSQLiteQuery
{
public:

    CCeSQLiteQuery();

    CCeSQLiteQuery(const CCeSQLiteQuery& rQuery);

    CCeSQLiteQuery(sqlite3* pDB,
				sqlite3_stmt* pVM,
                bool bEof,
                bool bOwnVM=true);

    CCeSQLiteQuery& operator=(const CCeSQLiteQuery& rQuery);

    virtual ~CCeSQLiteQuery();

    int numFields();

    int fieldIndex(const char* szField);
    const char* fieldName(int nCol);

    const char* fieldDeclType(int nCol);
    int fieldDataType(int nCol);

    const char* fieldValue(int nField);
    const char* fieldValue(const char* szField);

    int getIntField(int nField, int nNullValue=0);
    int getIntField(const char* szField, int nNullValue=0);

	sqlite_int64 getInt64Field(int nField, sqlite_int64 nNullValue=0);
	sqlite_int64 getInt64Field(const char* szField, sqlite_int64 nNullValue=0);

    double getFloatField(int nField, double fNullValue=0.0);
    double getFloatField(const char* szField, double fNullValue=0.0);

    const char* getStringField(int nField, const char* szNullValue="");
    const char* getStringField(const char* szField, const char* szNullValue="");

    const unsigned char* getBlobField(int nField, int& nLen);
    const unsigned char* getBlobField(const char* szField, int& nLen);

	bool fieldIsNull(int nField);
    bool fieldIsNull(const char* szField);

    bool eof();

    void nextRow();

    void finalize();

private:

    void checkVM();

	sqlite3* mpDB;
    sqlite3_stmt* mpVM;
    bool mbEof;
    int mnCols;
    bool mbOwnVM;
};

class CCeSQLiteTable
{
public:

    CCeSQLiteTable();

    CCeSQLiteTable(const CCeSQLiteTable& rTable);

    CCeSQLiteTable(char** paszResults, int nRows, int nCols);

    virtual ~CCeSQLiteTable();

    CCeSQLiteTable& operator=(const CCeSQLiteTable& rTable);

    int numFields();

    int numRows();

    const char* fieldName(int nCol);

    const char* fieldValue(int nField);
    const char* fieldValue(const char* szField);

    int getIntField(int nField, int nNullValue=0);
    int getIntField(const char* szField, int nNullValue=0);

    double getFloatField(int nField, double fNullValue=0.0);
    double getFloatField(const char* szField, double fNullValue=0.0);

    const char* getStringField(int nField, const char* szNullValue="");
    const char* getStringField(const char* szField, const char* szNullValue="");

	CString getCStringField(int nField);
	CString getCStringField(const char* szField);

    bool fieldIsNull(int nField);
    bool fieldIsNull(const char* szField);

    void setRow(int nRow);

    void finalize();

private:

    void checkResults();

    int mnCols;
    int mnRows;
    int mnCurrentRow;
    char** mpaszResults;
};


class CCeSQLiteDB
{
public:
    CCeSQLiteDB();

    virtual ~CCeSQLiteDB();

    void open(const char* szFile);

    void close();

	CCeSQLiteQuery execQuery(const char* szSQL);
	CCeSQLiteTable getTable(const char* szSQL);

private:

    CCeSQLiteDB(const CCeSQLiteDB& db);
    CCeSQLiteDB& operator=(const CCeSQLiteDB& db);

    sqlite3_stmt* compile(const char* szSQL);

    void checkDB();

    sqlite3* mpDB;
    int mnBusyTimeoutMs;
};
