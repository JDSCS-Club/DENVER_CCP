// Page_Pei.cpp : 구현 파일입니다.
//

#include "stdafx.h"
#include "CCP.h"
#include "PageCI.h"
#include "CCPDlg.h"


// CPageCI 대화 상자입니다.

IMPLEMENT_DYNAMIC(CPageCI, CDialog)

CPageCI::CPageCI(CWnd* pParent /*=NULL*/)
	: CDialog(CPageCI::IDD, pParent)
{
	LOGFONT	logFT;
	logFT.lfHeight = 25;
	logFT.lfWidth = 0; 
	logFT.lfEscapement = 0; 
	logFT.lfOrientation = 0; 
	logFT.lfWeight = FW_BOLD; 
	logFT.lfItalic = FALSE; 
	logFT.lfUnderline = FALSE; 
	logFT.lfStrikeOut = FALSE; 
	logFT.lfCharSet = JOHAB_CHARSET; 
	logFT.lfOutPrecision = OUT_DEFAULT_PRECIS; 
	logFT.lfClipPrecision = CLIP_DEFAULT_PRECIS; 
	logFT.lfQuality = DEFAULT_QUALITY; 
	logFT.lfPitchAndFamily = DEFAULT_PITCH; 

    m_font.CreateFontIndirect(&logFT);

	m_pParent	= (CCCPDlg *)pParent;
	m_pStatus	= &(m_pParent->m_Status);
	m_pPacket	= &(m_pParent->m_Packet);
	
}

CPageCI::~CPageCI()
{


	m_font.DeleteObject();
}

void CPageCI::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_BTN_CAR1, m_BtnCar[0]);
	DDX_Control(pDX, IDC_BTN_CAR2, m_BtnCar[1]);
	DDX_Control(pDX, IDC_BTN_CAR3, m_BtnCar[2]);
	DDX_Control(pDX, IDC_BTN_CAR4, m_BtnCar[3]);
	DDX_Control(pDX, IDC_BTN_CAR5, m_BtnCar[4]);
	DDX_Control(pDX, IDC_BTN_CAR6, m_BtnCar[5]);
	DDX_Control(pDX, IDC_BTN_CAR7, m_BtnCar[6]);
	DDX_Control(pDX, IDC_BTN_CAR8, m_BtnCar[7]);
	DDX_Control(pDX, IDC_BTN_NO1, m_btnNumber[0]);
	DDX_Control(pDX, IDC_BTN_NO2, m_btnNumber[1]);
	DDX_Control(pDX, IDC_BTN_NO3, m_btnNumber[2]);
	DDX_Control(pDX, IDC_BTN_NO4, m_btnNumber[3]);
	DDX_Control(pDX, IDC_BTN_NO5, m_btnNumber[4]);
	DDX_Control(pDX, IDC_BTN_NO6, m_btnNumber[5]);
	DDX_Control(pDX, IDC_BTN_NO7, m_btnNumber[6]);
	DDX_Control(pDX, IDC_BTN_NO8, m_btnNumber[7]);
	DDX_Control(pDX, IDC_BTN_NO9, m_btnNumber[8]);
	DDX_Control(pDX, IDC_BTN_AUTO, m_btnAuto);
	DDX_Control(pDX, IDC_BTN_APPLY, m_btnApply);
	
}

BEGIN_MESSAGE_MAP(CPageCI, CDialog)
	ON_WM_ACTIVATE()
	ON_WM_ERASEBKGND()
	ON_WM_PAINT()
	ON_WM_LBUTTONDOWN()
	ON_WM_TIMER()
	ON_CONTROL_RANGE(BN_CLICKED, IDC_BTN_CAR1, IDC_BTN_CAR12,   &CPageCI::OnClick_CarList)
	ON_CONTROL_RANGE(BN_CLICKED, IDC_BTN_NO1, IDC_BTN_NO9,   &CPageCI::OnClick_Number)
	ON_BN_CLICKED(IDC_BTN_AUTO, &CPageCI::OnBnClickedBtnAuto)
	ON_BN_CLICKED(IDC_BTN_APPLY, &CPageCI::OnBnClickedBtnApply)
END_MESSAGE_MAP()

// CPageCI 메시지 처리기입니다.
BOOL CPageCI::OnInitDialog()
{
	CDialog::OnInitDialog();

	CPaintDC dc(this);

	SetWindowPos(NULL, 2, 57, 644, 318, SWP_NOZORDER);

	h_instance = AfxGetInstanceHandle();

	m_BtnCar[0].SetWindowPos(NULL,	12, 25, 144, 51, TRUE);
	m_BtnCar[1].SetWindowPos(NULL,	172, 25, 144, 51, TRUE);
	m_BtnCar[2].SetWindowPos(NULL,	332, 25, 144, 51, TRUE);
	m_BtnCar[3].SetWindowPos(NULL,	492, 25, 144, 51, TRUE);
	m_BtnCar[4].SetWindowPos(NULL,	12,  130, 144, 51, TRUE);
	m_BtnCar[5].SetWindowPos(NULL,	172, 130, 144, 51, TRUE);
	m_BtnCar[6].SetWindowPos(NULL,	332, 130, 144, 51, TRUE);
	m_BtnCar[7].SetWindowPos(NULL,	492, 130, 144, 51, TRUE);

	for(int i=0; i<8; i++)
	{
		m_BtnCar[i].SetPushButton();
		m_BtnCar[i].SetTwoState( true );
		m_BtnCar[i].SetBitmapFromFile( _T(IDB_CI_CAR_NORMAL), _T(IDB_CI_CAR_SELECT), _T(IDB_CI_CAR_ERROR) );
		
		m_BtnCar[i].SetShowCaption( true );
		m_BtnCar[i].SetFont(_T("Tahoma"), 25);
		m_BtnCar[i].SetTextOffset( -10, 0 );

		m_pPacket->PAC.CI_USER_INPUT[i] = (i+1);
	}

	int nBtnWidth = 58;
    m_btnAuto.MoveWindow(9 + (nBtnWidth*0), 250, nBtnWidth, 52, TRUE);
    m_btnNumber[0].MoveWindow(9 + (nBtnWidth*1), 250, nBtnWidth, 52, TRUE);
    m_btnNumber[1].MoveWindow(9 + (nBtnWidth*2), 250, nBtnWidth, 52, TRUE);
    m_btnNumber[2].MoveWindow(9 + (nBtnWidth*3), 250, nBtnWidth, 52, TRUE);
    m_btnNumber[3].MoveWindow(9 + (nBtnWidth*4), 250, nBtnWidth, 52, TRUE);
    m_btnNumber[4].MoveWindow(9 + (nBtnWidth*5), 250, nBtnWidth, 52, TRUE);
    m_btnNumber[5].MoveWindow(9 + (nBtnWidth*6), 250, nBtnWidth, 52, TRUE);
    m_btnNumber[6].MoveWindow(9 + (nBtnWidth*7), 250, nBtnWidth, 52, TRUE);
    m_btnNumber[7].MoveWindow(9 + (nBtnWidth*8), 250, nBtnWidth, 52, TRUE);
    //m_btnNumber[8].MoveWindow(10 + (52*9), 250, 52, 52, TRUE);
	m_btnApply.MoveWindow(9 + (nBtnWidth*9), 250, 102, 52, TRUE);

	for(int i=0; i<9; i++)
	{
		m_btnNumber[i].SetBitmapFromFile(_T(IDB_CI_NUMBER_UP), _T(IDB_CI_NUMBER_DN) );
		m_btnNumber[i].SetShowCaption(TRUE);
		m_btnNumber[i].SetTextColor( RGB(128, 0, 128), RGB(128, 0, 128) );
	}
	
	m_btnAuto.SetBitmapFromFile(_T(IDB_CI_NUMBER_UP), _T(IDB_CI_NUMBER_DN) );
	m_btnAuto.SetShowCaption(TRUE);
	m_btnAuto.SetTextColor( RGB(128, 0, 128), RGB(128, 0, 128) );

	m_btnApply.SetBitmapFromFile(_T(IDB_NUMBER_UP), _T(IDB_NUMBER_DN) );
	m_btnApply.SetShowCaption(TRUE);
	m_btnApply.SetTextColor( RGB(128, 0, 128), RGB(128, 0, 128) );
	
	SetTimer(1, 1000, NULL);

	return TRUE;  // return TRUE unless you set the focus to a control
	// 예외: OCX 속성 페이지는 FALSE를 반환해야 합니다.
}

void CPageCI::OnActivate(UINT nState, CWnd* pWndOther, BOOL bMinimized)
{
	CDialog::OnActivate(nState, pWndOther, bMinimized);

	if( nState == 1 )
	{
		memcpy( m_pPacket->PAC.CI_USER_INPUT, m_pPacket->PAC.CI, sizeof(BYTE) * 8 );
		UpdateCarList(true);
	}
}

BOOL CPageCI::OnEraseBkgnd(CDC* pDC)
{
	pDC->BitBlt( 0, 0, 644, 318, m_pParent->m_dcPageBG[6].GetDC(), 0, 0, SRCCOPY );
	return 0;
}

UINT CPageCI::GetCarMarriedType(CAR_DATA *pCarData)
{
	if( pCarData )
	{
		if( (pCarData->CARN & 0x01) == 0x01 )	// Married A
		{
			return 2;
		}
		else
		if( (pCarData->CARN & 0x01) == 0x00 )	// Married B
		{
			return 3;
		}
		else
		{
			return 2;
		}
	}

	return 0;

}

void CPageCI::OnBnClickedBtnAuto()
{
	UINT nCarCount = m_pPacket->GetCarCount();

	for( int i=0; i<nCarCount; i++)
	{
		m_BtnCar[i].SetPush(FALSE);
		//m_byCI[i] = (i+1);
		m_pPacket->PAC.CI_USER_INPUT[i] = (i+1);
	}

	for( int i=nCarCount; i<8; i++)
	{
		m_BtnCar[i].SetPush(FALSE);
		//m_byCI[i] = 0;
		m_pPacket->PAC.CI_USER_INPUT[i] = 0;
	}
}

void CPageCI::OnBnClickedBtnApply()
{
	UINT nCarCount = m_pPacket->GetCarCount();
	BOOL bSameIndex = FALSE;

	for( int i=0; i<8; i++)
	{
		m_BtnCar[i].SetPush(FALSE);
	}

	for( int i=0; i<nCarCount; i++)
	{
		if( m_pPacket->PAC.CI_USER_INPUT[i] == 0x00 )
		{
			bSameIndex = TRUE;
			break;
		}

		for( int j=0; j<nCarCount; j++)
		{
			if( i == j ) continue;

			if( m_pPacket->PAC.CI_USER_INPUT[i] == m_pPacket->PAC.CI_USER_INPUT[j] )
			{
				bSameIndex = TRUE;
				break;
			}
		}

		if( bSameIndex )
		{
			break;
		}
	}

	if( bSameIndex )
	{
		m_pParent->UpdateCaption( CAPTION_CI );
	}
	else
	{
		memcpy( m_pPacket->PAC.CI_USER, m_pPacket->PAC.CI_USER_INPUT, sizeof(BYTE) * 8 );
		m_pParent->UpdateCaption( CAPTION_CONFIG_CI );
	}
}

void CPageCI::OnClick_CarList(UINT	nID)
{
	int nCarIndex = nID - IDC_BTN_CAR1;

	for( int i=0; i<8; i++)
	{
		if( i == nCarIndex )	m_BtnCar[i].SetPush(TRUE);
		else					m_BtnCar[i].SetPush(FALSE);
	}

	RedrawWindow();
}

void CPageCI::OnClick_Number(UINT nID)
{
	int nBtnIndex = nID - IDC_BTN_NO1;

	for( int i=0; i<8; i++)
	{
		if( m_BtnCar[i].IsSetPush() )
		{
			//m_pPacket->SetCI(i, nBtnIndex);
			//m_byCI[i] = (nBtnIndex+1);
			m_pPacket->PAC.CI_USER_INPUT[i] = (nBtnIndex+1);
			UpdateCarList(true);
			RedrawWindow();
			return;
		}
	}
}

void CPageCI::UpdateCarList(bool bShow)
{
	UINT nCarCount = m_pPacket->GetCarCount();

	for(UINT i=0; i<nCarCount; i++)
	{
		UINT	nCarMarriedType;
		bool	bCarError = false;
		CString strCarNumber[2];

		CAR_DATA *pCarData = m_pPacket->GetCarData(i);
		
		UINT nCarNumber = pCarData->CARN;
		//if( nCarNumber & 0x00 )
		//{	
		//	nCarNumber++;
		//}
		//else
		//{
		//	nCarNumber--;
		//}

		//strCarNumber[0].Format(_T("%d"), pCarData->CI );

		if( pCarData->bErrCI )
		{
			m_BtnCar[i].SetAlternate( TRUE );
		}
		else
		{
			m_BtnCar[i].SetAlternate( FALSE );
		}

		strCarNumber[0].Format(_T("%d / %d"), m_pPacket->PAC.CI_LIC[i] , m_pPacket->PAC.CI_USER_INPUT[i] );
		strCarNumber[1].Format(_T("CI#%04d"), pCarData->CARN );

		m_BtnCar[i].SetButtonText(strCarNumber[0]);
		m_BtnCar[i].SetButtonText2(strCarNumber[1]);
		m_BtnCar[i].ShowWindow(SW_SHOW);
	}

	for(int i=nCarCount; i<8; i++)
	{
		m_BtnCar[i].ShowWindow(SW_HIDE);
	}

	RedrawWindow();
}

void CPageCI::OnPaint()
{
	CPaintDC dc(this); // device context for painting
	
	CDC		dcBuffer;
	CBitmap	bmpBuffer;

	dcBuffer.CreateCompatibleDC( &dc );
	bmpBuffer.CreateCompatibleBitmap( &dc, 644, 318 );
	dcBuffer.SelectObject( &bmpBuffer );

	dcBuffer.BitBlt( 0, 0, 644, 318, m_pParent->m_dcPageBG[6].GetDC(), 0, 0, SRCCOPY );

	dc.BitBlt( 0, 0, 644, 318, &dcBuffer, 0, 0, SRCCOPY );

	dcBuffer.DeleteDC();
	bmpBuffer.DeleteObject();
}

void CPageCI::OnTimer(UINT_PTR nIDEvent)
{
	UpdateCarList(true);

	if( m_pParent->m_mgrPage.GetCurrentPage() == PAGE_ID_CI )
	{
		if( !m_pStatus->GetCI_Valid() )
		{
			m_pParent->UpdateCaption( CAPTION_CI );
		}
		else
		{
			m_pParent->UpdateCaption( CAPTION_CONFIG_CI );
		}
	}

	CDialog::OnTimer(nIDEvent);
}

void CPageCI::FreeResource()
{
	for(int i=0; i<8; i++) m_BtnCar[i].FreeResource();
	for(int i=0; i<9; i++) m_btnNumber[i].FreeResource();
	m_btnAuto.FreeResource();
	m_btnApply.FreeResource();
}

