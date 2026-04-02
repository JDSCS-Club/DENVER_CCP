// Page_Pei.cpp : 구현 파일입니다.
//

#include "stdafx.h"
#include "CCP.h"
#include "PageCar.h"
#include "CCPDlg.h"


// CPageCar 대화 상자입니다.

IMPLEMENT_DYNAMIC(CPageCar, CDialog)

CPageCar::CPageCar(CWnd* pParent /*=NULL*/)
	: CDialog(CPageCar::IDD, pParent)
{
	m_nDisplayMode	= 0;
	m_nDisplayType  = 0;

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

CPageCar::~CPageCar()
{


	m_font.DeleteObject();
}

void CPageCar::DoDataExchange(CDataExchange* pDX)
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
	DDX_Control(pDX, IDC_BTN_CAR9, m_BtnCar[8]);
	DDX_Control(pDX, IDC_BTN_CAR10, m_BtnCar[9]);
	DDX_Control(pDX, IDC_BTN_CAR11, m_BtnCar[10]);
	DDX_Control(pDX, IDC_BTN_CAR12, m_BtnCar[11]);
	DDX_Control(pDX, IDC_BTN_SIMULATION, m_BtnSimulation);
}

BEGIN_MESSAGE_MAP(CPageCar, CDialog)
	ON_WM_ACTIVATE()
	ON_WM_ERASEBKGND()
	ON_WM_PAINT()
	ON_WM_LBUTTONDOWN()
	ON_WM_TIMER()
	ON_CONTROL_RANGE(BN_CLICKED, IDC_BTN_CAR1, IDC_BTN_CAR12,   &CPageCar::OnClick_CarList)
	ON_BN_CLICKED(IDC_BTN_SIMULATION, &CPageCar::OnClick_Simulation)
	ON_MESSAGE(WM_CHANGE_CAR_TYPE, &CPageCar::OnMsg_ChangeType)
END_MESSAGE_MAP()

// CPageCar 메시지 처리기입니다.
BOOL CPageCar::OnInitDialog()
{
	CDialog::OnInitDialog();

	CPaintDC dc(this);

	SetWindowPos(NULL, 2, 57, 644, 318, SWP_NOZORDER);

	h_instance = AfxGetInstanceHandle();

	m_BtnCar[0].SetWindowPos(NULL,	12, 25, 144, 51, TRUE);
	m_BtnCar[1].SetWindowPos(NULL,	172, 25, 144, 51, TRUE);
	m_BtnCar[2].SetWindowPos(NULL,	332, 25, 144, 51, TRUE);
	m_BtnCar[3].SetWindowPos(NULL,	492, 25, 144, 51, TRUE);
	m_BtnCar[4].SetWindowPos(NULL,	12,  105, 144, 51, TRUE);
	m_BtnCar[5].SetWindowPos(NULL,	172, 105, 144, 51, TRUE);
	m_BtnCar[6].SetWindowPos(NULL,	332, 105, 144, 51, TRUE);
	m_BtnCar[7].SetWindowPos(NULL,	492, 105, 144, 51, TRUE);
	m_BtnCar[8].SetWindowPos(NULL,	12, 185, 144, 51, TRUE);
	m_BtnCar[9].SetWindowPos(NULL,	172, 185, 144, 51, TRUE);
	m_BtnCar[10].SetWindowPos(NULL, 332, 185, 144, 51, TRUE);
	m_BtnCar[11].SetWindowPos(NULL, 492, 185, 144, 51, TRUE);

	for(int i=0; i<12; i++)
	{
		m_BtnCar[i].SetTwoState( true );
		m_BtnCar[i].SetBitmapFromFile( _T(IDB_CHECK_CAR_GREEN), _T(IDB_CHECK_CAR_RED) );
		
		m_BtnCar[i].SetShowCaption( true );
		m_BtnCar[i].SetFont(_T("Tahoma"), 25);
		m_BtnCar[i].SetTextOffset( 0, 0 );
	}

	m_BtnSimulation.SetBitmapFromFile(_T("\\NandFlash\\res\\simulation_up.bmp") , _T("\\NandFlash\\res\\simulation_dn.bmp") );
	m_BtnSimulation.SetWindowPos(NULL, 338, 258, 262, 40, TRUE);
	m_BtnSimulation.SetPushButton();

	if( m_nDisplayType )
	{
		m_BtnSimulation.ShowWindow(SW_HIDE);
	}

	m_dcBG[0].SetBitmap( _T(IDB_CHECK_SINGLE_BG) );
	m_dcBG[1].SetBitmap( _T(IDB_CHECK_MARRIEDA_BG) );
	m_dcBG[2].SetBitmap( _T(IDB_CHECK_MARRIEDB_BG) );
	m_dcBG[3].SetBitmap( _T(IDB_PEI_MARRIEDA_BG) );
	m_dcBG[4].SetBitmap( _T(IDB_PEI_MARRIEDB_BG) );

	m_dcArrow.SetBitmap( _T("\\NandFlash\\res\\check_arrow.bmp") );

	m_dcFDI1.SetBitmap( _T(IDB_CHECK_FDI1) );
	m_dcDPOA.SetBitmap( _T(IDB_CHECK_DPOA) );
	m_dcVOIPC1.SetBitmap( _T(IDB_CHECK_VOIPC1) );
	m_dcCCPA.SetBitmap( _T(IDB_CHECK_CCPA) );
	m_dcCRA.SetBitmap( _T(IDB_CHECK_CRA) );
	m_dcPII1.SetBitmap( _T(IDB_CHECK_PII1) );
	m_dcPID21.SetBitmap( _T(IDB_CHECK_PID21) );
	m_dcPII3.SetBitmap( _T(IDB_CHECK_PII3) );
	//m_dcPID23.SetBitmap( _T(IDB_CHECK_PID23) );
	m_dcDPHA.SetBitmap( _T(IDB_CHECK_DPHA) );

	m_dcFDI2.SetBitmap( _T(IDB_CHECK_FDI2) );
	m_dcDPOB.SetBitmap( _T(IDB_CHECK_DPOB) );
	m_dcVOIPC2.SetBitmap( _T(IDB_CHECK_VOIPC2) );
	m_dcCCPB.SetBitmap( _T(IDB_CHECK_CCPB) );
	m_dcCRB.SetBitmap( _T(IDB_CHECK_CRB) );
	m_dcPII2.SetBitmap( _T(IDB_CHECK_PII2) );
	m_dcPID22.SetBitmap( _T(IDB_CHECK_PID22) );
	m_dcPII4.SetBitmap( _T(IDB_CHECK_PII4) );
	//m_dcPID24.SetBitmap( _T(IDB_CHECK_PID24) );
	m_dcDPHB.SetBitmap( _T(IDB_CHECK_DPHB) );

	m_dcPID11.SetBitmap( _T(IDB_CHECK_PID11) );
	m_dcPID12.SetBitmap( _T(IDB_CHECK_PID12) );
	m_dcSDI1.SetBitmap( _T(IDB_CHECK_SDI1) );
	m_dcPEI1.SetBitmap( _T(IDB_CHECK_PEI1) );
	//m_dcCPO1.SetBitmap( _T(IDB_CHECK_CPO1) );
	m_dcSDI2.SetBitmap( _T(IDB_CHECK_SDI2) );

	m_dcPID15.SetBitmap( _T(IDB_CHECK_PID15) );
	m_dcPID16.SetBitmap( _T(IDB_CHECK_PID16) );
	m_dcSDI5.SetBitmap( _T(IDB_CHECK_SDI5) );
	m_dcPEI4.SetBitmap( _T(IDB_CHECK_PEI4) );
	//m_dcCPO3.SetBitmap( _T(IDB_CHECK_CPO3) );
//	m_dcPEI5.SetBitmap( _T(IDB_CHECK_PEI5) );
	m_dcSDI6.SetBitmap( _T(IDB_CHECK_SDI6)  );

	m_dcPID13.SetBitmap( _T(IDB_CHECK_PID13) );
	m_dcPID14.SetBitmap( _T(IDB_CHECK_PID14) );
	m_dcSDI3.SetBitmap( _T(IDB_CHECK_SDI3) );
	m_dcPEI2.SetBitmap( _T(IDB_CHECK_PEI2) );
	//m_dcCPO2.SetBitmap( _T(IDB_CHECK_CPO2) );
	m_dcPEI3.SetBitmap( _T(IDB_CHECK_PEI3) );
	m_dcSDI4.SetBitmap( _T(IDB_CHECK_SDI4) );

	m_dcPID17.SetBitmap( _T(IDB_CHECK_PID17) );
	m_dcPID18.SetBitmap( _T(IDB_CHECK_PID18) );
	m_dcSDI7.SetBitmap( _T(IDB_CHECK_SDI7) );
	//m_dcCPO4.SetBitmap( _T(IDB_CHECK_CPO4) );
//	m_dcPEI6.SetBitmap( _T(IDB_CHECK_PEI6) );
	m_dcSDI8.SetBitmap( _T(IDB_CHECK_SDI8) );

	m_dcCI.SetBitmap( _T(IDB_CHECK_CI) );

	SetTimer(1, 1000, NULL);

	return TRUE;  // return TRUE unless you set the focus to a control
	// 예외: OCX 속성 페이지는 FALSE를 반환해야 합니다.
}

void CPageCar::OnActivate(UINT nState, CWnd* pWndOther, BOOL bMinimized)
{
	CDialog::OnActivate(nState, pWndOther, bMinimized);

	if( nState == 1 )
	{
		m_nDisplayMode = 0;
		UpdateCarList(true);
	}
}

LRESULT CPageCar::OnMsg_ChangeType(WPARAM wparam, LPARAM lparam)
{
		 if( wparam == PARAM_SET_CHECK )	m_nDisplayType = 0;
	else if( wparam == PARAM_SET_PEI )		m_nDisplayType = 1;

	return 0;
}

BOOL CPageCar::OnEraseBkgnd(CDC* pDC)
{
	if( m_nDisplayMode == 0 )
	{
		pDC->BitBlt( 0, 0, 644, 318, m_pParent->m_dcPageBG[5].GetDC(), 0, 0, SRCCOPY );
	}
	else
	{
		int nBGIndex = 0;

		if( m_nDisplayType == 0 && m_nDisplayMode == 1 )
		{
			nBGIndex = 0;
		}
		else
		if( m_nDisplayType == 0 && m_nDisplayMode == 2 )
		{
			nBGIndex = 1;
		}
		else
		if( m_nDisplayType == 0 && m_nDisplayMode == 3 )
		{
			nBGIndex = 2;
		}
		if( m_nDisplayType == 1 && m_nDisplayMode == 1 )
		{
			nBGIndex = 0;
		}
		else
		if( m_nDisplayType == 1 && m_nDisplayMode == 2 )
		{
			nBGIndex = 3;
		}
		else
		if( m_nDisplayType == 1 && m_nDisplayMode == 3 )
		{
			nBGIndex = 4;
		}

		pDC->BitBlt( 0, 0, 644, 318, m_dcBG[nBGIndex].GetDC(), 0, 0, SRCCOPY );
	}

	return 0;
}

UINT CPageCar::GetCarMarriedType(CAR_DATA *pCarData)
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

void CPageCar::OnClick_CarList(UINT	nID)
{
	CAR_DATA	*pCarData = NULL;
	
	m_nDisplayCarIndex = nID - IDC_BTN_CAR1;
	
	UpdateCarList(false);

	pCarData = m_pPacket->GetCarData(m_nDisplayCarIndex);

	m_nDisplayMode = GetCarMarriedType( pCarData );

	Invalidate(false);

	if( m_pParent->m_mgrPage.GetCurrentPage() == PAGE_ID_PEI && m_pStatus->IsSetPEI() )
	{
		m_pStatus->SetCheckPEI(true);
	}
}

void CPageCar::OnClick_Simulation()
{
	if( m_pParent->m_Route.IsSimulate() )
	{
		m_pParent->StopSimulation();
	}
	else
	{
		if( m_pParent->m_Status.IsSetCabonKey() && m_pParent->m_Route.GetTrainNumber() && m_pParent->m_Route.GetCrewID() )
		{
			m_pParent->StartSimulation();

			m_pParent->m_mgrPage.ShowPage(PAGE_ID_HOME);
			m_pParent->RedrawButton(PAGE_ID_HOME);
		}
	}
	

	m_BtnSimulation.SetPush( m_pParent->m_Route.IsSimulate() );

	Invalidate(false);
}

void CPageCar::UpdateCarList(bool bShow)
{
	if( !bShow )
	{
		for(int i=0; i<12; i++)
		{
			m_BtnCar[i].ShowWindow(SW_HIDE);
		}

		m_BtnSimulation.ShowWindow(SW_HIDE);

		return;
	}

	UINT nCarCount = m_pPacket->GetCarCount();

	for(UINT i=0; i<nCarCount; i++)
	{
		UINT	nCarMarriedType;
		bool	bCarError = false;
		CString strCarNumber;

		CAR_DATA *pCarData = m_pPacket->GetCarData(i);
		
		UINT nCarNumber = pCarData->CARN;
		//if( nCarNumber & 0x01 )
		//{	
		//	nCarNumber++;
		//}
		//else
		//{
		//	nCarNumber--;
		//}

		strCarNumber.Format(_T("Car #%04d"), nCarNumber );

		nCarMarriedType = GetCarMarriedType(pCarData);

		if( m_nDisplayType == 0 )
		{
			if( nCarMarriedType == 2 )	bCarError = IsErrorMarriedACar(pCarData);
			else if( nCarMarriedType == 3 )	bCarError = IsErrorMarriedBCar(pCarData);
		}
		else
		{
			if( nCarMarriedType == 2 )	bCarError = CHECK_PEI_MARRIEDA(pCarData->DATA);
			else if( nCarMarriedType == 3 )	bCarError = CHECK_PEI_MARRIEDB(pCarData->DATA);
		}

		m_BtnCar[i].SetPush( bCarError );

		m_BtnCar[i].SetButtonText(strCarNumber);
		m_BtnCar[i].ShowWindow(SW_SHOW);
	}

	for(UINT i=nCarCount; i<12; i++)
	{
		m_BtnCar[i].ShowWindow(SW_HIDE);
	}

	if( m_nDisplayType == 0 && bShow )
	{
		m_BtnSimulation.SetPush( m_pParent->m_Route.IsSimulate() );
		m_BtnSimulation.ShowWindow(SW_SHOW);
	}
	else
	{
		m_BtnSimulation.ShowWindow(SW_HIDE);
	}

	RedrawWindow();
}

void CPageCar::OnPaint()
{
	CPaintDC dc(this); // device context for painting
	
	CDC		dcBuffer;
	CBitmap	bmpBuffer;

	dcBuffer.CreateCompatibleDC( &dc );
	bmpBuffer.CreateCompatibleBitmap( &dc, 644, 318 );
	dcBuffer.SelectObject( &bmpBuffer );

	if( m_nDisplayMode == 0 )
	{
		dcBuffer.BitBlt( 0, 0, 644, 318, m_pParent->m_dcPageBG[5].GetDC(), 0, 0, SRCCOPY );
	}
	else
	{
		int nBGIndex = 0;

		if( m_nDisplayType == 0 && m_nDisplayMode == 1 )
		{
			nBGIndex = 0;
		}
		else
		if( m_nDisplayType == 0 && m_nDisplayMode == 2 )
		{
			nBGIndex = 1;
		}
		else
		if( m_nDisplayType == 0 && m_nDisplayMode == 3 )
		{
			nBGIndex = 2;
		}
		if( m_nDisplayType == 1 && m_nDisplayMode == 1 )
		{
			nBGIndex = 0;
		}
		else
		if( m_nDisplayType == 1 && m_nDisplayMode == 2 )
		{
			nBGIndex = 3;
		}
		else
		if( m_nDisplayType == 1 && m_nDisplayMode == 3 )
		{
			nBGIndex = 4;
		}

		dcBuffer.BitBlt( 0, 0, 644, 318, m_dcBG[nBGIndex].GetDC(), 0, 0, SRCCOPY );
	}

	CAR_DATA *pCarData = m_pPacket->GetCarData(m_nDisplayCarIndex);

	if( pCarData )
	{
		if( m_nDisplayType == 0 )
		{
				 if( m_nDisplayMode ==  2 )	DrawMarriedACar( &dcBuffer, pCarData );
			else if( m_nDisplayMode ==  3 )	DrawMarriedBCar( &dcBuffer, pCarData );
		}
		else
		{
				 if( m_nDisplayMode ==  2 )	DrawPEIMarriedACar( &dcBuffer, pCarData );
			else if( m_nDisplayMode ==  3 )	DrawPEIMarriedBCar( &dcBuffer, pCarData );
		}

		if( m_nDisplayMode )
		{
			CString strCarNumber;

			UINT nCarNumber = pCarData->CARN;
			//if( nCarNumber & 0x01 )
			//{	
			//	nCarNumber++;
			//}
			//else
			//{
			//	nCarNumber--;
			//}

			strCarNumber.Format(_T("Car #%04d"), nCarNumber );

			//CRect rectCarNumber(220, 150, 415, 180);

			dcBuffer.SetBkMode(TRANSPARENT);
			dcBuffer.SelectObject(&m_font);

			dcBuffer.DrawText(strCarNumber, CRect(220, 150, 415, 180),  DT_CENTER | DT_VCENTER | DT_SINGLELINE);
		}
		else if( m_nDisplayType == 0 )
		{
			CString strLabel;

			if( m_pParent->m_Status.IsSetCabonKey() )
			{
				UINT uCarN = m_pPacket->LIC.CARN;
				BYTE byCCPID = m_pParent->m_Status.GetCCPID();

				switch( byCCPID )
				{
				case ID_CCP_A:		uCarN -= ( (( uCarN & 0x01 ) == 0x00 )?1:0);		break;
				case ID_CCP_B:		uCarN += ( (( uCarN & 0x01 ) == 0x01 )?1:0);		break;
				}

				if( uCarN >= 10000 ) uCarN = 4001;

				switch( byCCPID )
				{
				case ID_CCP_A:		strLabel.Format( _T("%d CCP_A"), uCarN );		break;
				case ID_CCP_B:		strLabel.Format( _T("%d CCP_B"), uCarN );		break;
				}

			}
			else
			{
				if( m_pParent->m_Status.GetCCPID() == ID_CCP_A )
				{
					strLabel.Format( _T("Slave CCP_A") );
				}
				else
				{
					strLabel.Format( _T("Slave CCP_B") );
				}
			}

			dcBuffer.SelectObject( &m_pParent->m_ftSchedule);

			dcBuffer.DrawText(strLabel, CRect(50,265,220,285),  DT_LEFT | DT_VCENTER | DT_SINGLELINE);
		}
	}

	// 차량에 마스터 Cab를 표기하는 부분.
	if( m_nDisplayMode == 0 && m_pParent->m_mgrPage.GetCurrentPage() == PAGE_ID_CHECK )
	{
		UINT nCarCount = m_pPacket->GetCarCount();
		UINT nCarMarriedType;
		for(UINT i=0; i<nCarCount; i++)
		{
			CAR_DATA *pCarData = m_pPacket->GetCarData(i);

			nCarMarriedType = GetCarMarriedType(pCarData);

			if( nCarMarriedType == 2 )								// Married A
			{	
				if( CHECK_CABA(pCarData->DATA) )
				{
					dcBuffer.BitBlt( 16 + ( i % 4 * 160 ), 4 + ( (i / 4) * 80 ), m_dcArrow.Width(), m_dcArrow.Height(), m_dcArrow.GetDC(), 0, 0, SRCCOPY );
				}
			}			
			else if( nCarMarriedType == 3 )								// Married B 
			{
				if( CHECK_CABB(pCarData->DATA) )
				{
					dcBuffer.BitBlt( 16 + ( i % 4 * 160 ), 4 + ( (i / 4) * 80 ), m_dcArrow.Width(), m_dcArrow.Height(), m_dcArrow.GetDC(), 0, 0, SRCCOPY );
				}
			}	

		}
	}

	dc.BitBlt( 0, 0, 644, 318, &dcBuffer, 0, 0, SRCCOPY );

	dcBuffer.DeleteDC();
	bmpBuffer.DeleteObject();

}

void CPageCar::DrawMarriedACar(CDC *pDC, CAR_DATA *pCarData)
{
	//
	if( CHECK_FDIA(pCarData->DATA) )
	{
		pDC->BitBlt(10, 56, m_dcFDI1.Width(), m_dcFDI1.Height(), m_dcFDI1.GetDC(), 0, 0, SRCCOPY);	
	}

	if( CHECK_DPOA(pCarData->DATA) )
	{
		pDC->BitBlt(42, 10, m_dcDPOA.Width(), m_dcDPOA.Height(), m_dcDPOA.GetDC(), 0, 0, SRCCOPY);	
	}


	//if( CHECK_VOIPC1(pCarData->DATA) )
	//{
	//	pDC->BitBlt(42, 71, m_dcVOIPC1.Width(), m_dcVOIPC1.Height(), m_dcVOIPC1.GetDC(), 0, 0, SRCCOPY);	
	//}

	if( CHECK_CCPA(pCarData->DATA) )
	{
		pDC->BitBlt(41, 104, m_dcCCPA.Width(), m_dcCCPA.Height(), m_dcCCPA.GetDC(), 0, 0, SRCCOPY);	
	}

	if( CHECK_CRA1(pCarData->DATA) )
	{
		pDC->BitBlt(75, 200, m_dcCRA.Width(), m_dcCRA.Height(), m_dcCRA.GetDC(), 0, 0, SRCCOPY);	
	}

	if( CHECK_PII1A(pCarData->DATA) )
	{
		pDC->BitBlt(132, 132, m_dcPII1.Width(), m_dcPII1.Height(), m_dcPII1.GetDC(), 0, 0, SRCCOPY);	
	}

	if( CHECK_PID21A(pCarData->DATA) )
	{
		pDC->BitBlt(107, 200, m_dcPID21.Width(), m_dcPID21.Height(), m_dcPID21.GetDC(), 0, 0, SRCCOPY);	
	}

	if( CHECK_DPHA(pCarData->DATA) )
	{
		pDC->BitBlt(42, 200, m_dcDPHA.Width(), m_dcDPHA.Height(), m_dcDPHA.GetDC(), 0, 0, SRCCOPY);	
	}

	if( CHECK_PII2A(pCarData->DATA) )
	{
		pDC->BitBlt(486, 132, m_dcPII2.Width(), m_dcPII2.Height(), m_dcPII2.GetDC(), 0, 0, SRCCOPY);	
	}

	//
	if( CHECK_PID11A(pCarData->DATA) )
	{
		pDC->BitBlt(266, 200, m_dcPID11.Width(), m_dcPID11.Height(), m_dcPID11.GetDC(), 0, 0, SRCCOPY);	
	}

	if( CHECK_PID12A(pCarData->DATA) )
	{
		pDC->BitBlt(371, 200, m_dcPID12.Width(), m_dcPID12.Height(), m_dcPID12.GetDC(), 0, 0, SRCCOPY);	
	}

	if( CHECK_SDI1A(pCarData->DATA) )
	{
		pDC->BitBlt(148, 283, m_dcSDI1.Width(), m_dcSDI1.Height(), m_dcSDI1.GetDC(), 0, 0, SRCCOPY);	
	}

	if( CHECK_PEI1A(pCarData->DATA) )
	{
		pDC->BitBlt(214, 10, m_dcPEI1.Width(), m_dcPEI1.Height(), m_dcPEI1.GetDC(), 0, 0, SRCCOPY);	
	}

	//if( CHECK_CPO1(pCarData->DATA) )
	//{
	//	pDC->BitBlt(284, 283, m_dcCPO1.Width(), m_dcCPO1.Height(), m_dcCPO1.GetDC(), 0, 0, SRCCOPY);	
	//}

	if( CHECK_SDI2A(pCarData->DATA) )
	{
		pDC->BitBlt(465, 283, m_dcSDI2.Width(), m_dcSDI2.Height(), m_dcSDI2.GetDC(), 0, 0, SRCCOPY);	
	}

	//
	if( CHECK_PID13A(pCarData->DATA) )
	{
		pDC->BitBlt(266, 56, m_dcPID13.Width(), m_dcPID13.Height(), m_dcPID13.GetDC(), 0, 0, SRCCOPY);	
	}

	if( CHECK_PID14A(pCarData->DATA) )
	{
		pDC->BitBlt(371, 56, m_dcPID14.Width(), m_dcPID14.Height(), m_dcPID14.GetDC(), 0, 0, SRCCOPY);	
	}

	if( CHECK_SDI3A(pCarData->DATA) )
	{
		pDC->BitBlt(148, 10, m_dcSDI3.Width(), m_dcSDI3.Height(), m_dcSDI3.GetDC(), 0, 0, SRCCOPY);	
	}

	//if( CHECK_PEI3(pCarData->DATA) )
	//{
	//	pDC->BitBlt(397, 10, m_dcPEI3.Width(), m_dcPEI3.Height(), m_dcPEI3.GetDC(), 0, 0, SRCCOPY);	
	//}

	//if( CHECK_CPO2(pCarData->DATA) )
	//{
	//	pDC->BitBlt(284, 10, m_dcCPO2.Width(), m_dcCPO2.Height(), m_dcCPO2.GetDC(), 0, 0, SRCCOPY);	
	//}

	if( CHECK_PEI2A(pCarData->DATA) )
	{
		pDC->BitBlt(399, 283, m_dcPEI2.Width(), m_dcPEI2.Height(), m_dcPEI2.GetDC(), 0, 0, SRCCOPY);
	}

	if( CHECK_SDI4A(pCarData->DATA) )
	{
		pDC->BitBlt(465, 10, m_dcSDI4.Width(), m_dcSDI4.Height(), m_dcSDI4.GetDC(), 0, 0, SRCCOPY);	
	}

	if( pCarData->bErrCI )
	{
		pDC->BitBlt(301, 283, m_dcCI.Width(), m_dcCI.Height(), m_dcCI.GetDC(), 0, 0, SRCCOPY);	
	}
}

void CPageCar::DrawMarriedBCar(CDC *pDC, CAR_DATA *pCarData)
{
	if( CHECK_PII1B(pCarData->DATA) )
	{
		pDC->BitBlt(132, 132, m_dcPII3.Width(), m_dcPII3.Height(), m_dcPII3.GetDC(), 0, 0, SRCCOPY);	
	}

	//if( CHECK_PID23(pCarData->DATA) )
	//{
	//	pDC->BitBlt(10, 200, m_dcPID23.Width(), m_dcPID23.Height(), m_dcPID23.GetDC(), 0, 0, SRCCOPY);	
	//}

	//
	if( CHECK_FDIB(pCarData->DATA) )
	{
		pDC->BitBlt(607, 200, m_dcFDI2.Width(), m_dcFDI2.Height(), m_dcFDI2.GetDC(), 0, 0, SRCCOPY);	
	}

	if( CHECK_PID21B(pCarData->DATA) )
	{
		pDC->BitBlt(512, 56, m_dcPID22.Width(), m_dcPID22.Height(), m_dcPID22.GetDC(), 0, 0, SRCCOPY);	
	}

	if( CHECK_DPOB(pCarData->DATA) )
	{
		pDC->BitBlt(542, 249, m_dcDPOB.Width(), m_dcDPOB.Height(), m_dcDPOB.GetDC(), 0, 0, SRCCOPY);	
	}

	//if( CHECK_VOIPC2(pCarData->DATA) )
	//{
	//	pDC->BitBlt(541, 215, m_dcVOIPC2.Width(), m_dcVOIPC2.Height(), m_dcVOIPC2.GetDC(), 0, 0, SRCCOPY);	
	//}

	if( CHECK_CCPB(pCarData->DATA) )
	{
		pDC->BitBlt(543, 151, m_dcCCPB.Width(), m_dcCCPB.Height(), m_dcCCPB.GetDC(), 0, 0, SRCCOPY);	
	}

	if( CHECK_CRA2(pCarData->DATA) )
	{
		//pDC->BitBlt(510, 200, m_dcCRB.Width(), m_dcCRB.Height(), m_dcCRB.GetDC(), 0, 0, SRCCOPY);	
		pDC->BitBlt(544, 56, m_dcCRA.Width(), m_dcCRA.Height(), m_dcCRA.GetDC(), 0, 0, SRCCOPY);	
		
	}

	if( CHECK_PII1B(pCarData->DATA) )
	{
		pDC->BitBlt(486, 132, m_dcPII4.Width(), m_dcPII4.Height(), m_dcPII4.GetDC(), 0, 0, SRCCOPY);	
	}

	//if( CHECK_PID24(pCarData->DATA) )
	//{
	//	pDC->BitBlt(607, 56, m_dcPID24.Width(), m_dcPID24.Height(), m_dcPID24.GetDC(), 0, 0, SRCCOPY);	
	//}

	if( CHECK_DPHB(pCarData->DATA) )
	{
		pDC->BitBlt(576, 56, m_dcDPHB.Width(), m_dcDPHB.Height(), m_dcDPHB.GetDC(), 0, 0, SRCCOPY);	
	}

	//
	if( CHECK_PID11B(pCarData->DATA) )
	{
		pDC->BitBlt(266, 200, m_dcPID15.Width(), m_dcPID15.Height(), m_dcPID15.GetDC(), 0, 0, SRCCOPY);	
	}

	if( CHECK_PID12B(pCarData->DATA) )
	{
		pDC->BitBlt(371, 200, m_dcPID16.Width(), m_dcPID16.Height(), m_dcPID16.GetDC(), 0, 0, SRCCOPY);	
	}

	if( CHECK_SDI1B(pCarData->DATA) )
	{
		pDC->BitBlt(148, 283, m_dcSDI5.Width(), m_dcSDI5.Height(), m_dcSDI5.GetDC(), 0, 0, SRCCOPY);	
	}

	//if( CHECK_PEI6(pCarData->DATA) )
	//{
	//	pDC->BitBlt(397, 10, m_dcPEI6.Width(), m_dcPEI6.Height(), m_dcPEI6.GetDC(), 0, 0, SRCCOPY);	
	//}

	//if( CHECK_CPO3(pCarData->DATA) )
	//{
	//	pDC->BitBlt(329, 283, m_dcCPO3.Width(), m_dcCPO3.Height(), m_dcCPO3.GetDC(), 0, 0, SRCCOPY);	
	//}

	if( CHECK_PEI1B(pCarData->DATA) )
	{
		pDC->BitBlt(399, 283, m_dcPEI3.Width(), m_dcPEI3.Height(), m_dcPEI3.GetDC(), 0, 0, SRCCOPY);	
	}

	if( CHECK_SDI2B(pCarData->DATA) )
	{
		pDC->BitBlt(465, 283, m_dcSDI6.Width(), m_dcSDI6.Height(), m_dcSDI6.GetDC(), 0, 0, SRCCOPY);	
	}

	//
	if( CHECK_PID13B(pCarData->DATA) )
	{
		pDC->BitBlt(266, 56, m_dcPID17.Width(), m_dcPID17.Height(), m_dcPID17.GetDC(), 0, 0, SRCCOPY);	
	}

	if( CHECK_PID14B(pCarData->DATA) )
	{
		pDC->BitBlt(371, 56, m_dcPID18.Width(), m_dcPID18.Height(), m_dcPID18.GetDC(), 0, 0, SRCCOPY);	
	}

	if( CHECK_SDI3B(pCarData->DATA) )
	{
		pDC->BitBlt(148, 10, m_dcSDI7.Width(), m_dcSDI7.Height(), m_dcSDI7.GetDC(), 0, 0, SRCCOPY);	
	}

	//if( CHECK_CPO4(pCarData->DATA) )
	//{
	//	pDC->BitBlt(329, 10, m_dcCPO4.Width(), m_dcCPO4.Height(), m_dcCPO4.GetDC(), 0, 0, SRCCOPY);	
	//}

	//if( CHECK_PEI5(pCarData->DATA) )
	//{
	//	pDC->BitBlt(397, 283, m_dcPEI5.Width(), m_dcPEI5.Height(), m_dcPEI5.GetDC(), 0, 0, SRCCOPY);	
	//}

	if( CHECK_PEI2B(pCarData->DATA) )
	{
		pDC->BitBlt(214, 10, m_dcPEI4.Width(), m_dcPEI4.Height(), m_dcPEI4.GetDC(), 0, 0, SRCCOPY);	
	}

	if( CHECK_SDI4B(pCarData->DATA) )
	{
		pDC->BitBlt(465, 10, m_dcSDI8.Width(), m_dcSDI8.Height(), m_dcSDI8.GetDC(), 0, 0, SRCCOPY);	
	}

	if( pCarData->bErrCI )
	{
		pDC->BitBlt(304, 10, m_dcCI.Width(), m_dcCI.Height(), m_dcCI.GetDC(), 0, 0, SRCCOPY);	
	}
}

//void CPageCar::DrawPEISingleCar(CDC *pDC, CAR_DATA *pCarData)
//{
//	DrawPEIMarriedACar(pDC, pCarData);
//}

void CPageCar::DrawPEIMarriedACar(CDC *pDC, CAR_DATA *pCarData)
{
	if( CHECK_PEICALL1A(pCarData->DATA) )
	{
		pDC->BitBlt(214, 10, m_dcPEI1.Width(), m_dcPEI1.Height(), m_dcPEI1.GetDC(), 0, 0, SRCCOPY);	
	}

	if( CHECK_PEICALL2A(pCarData->DATA) )
	{
		pDC->BitBlt(399, 283, m_dcPEI2.Width(), m_dcPEI2.Height(), m_dcPEI2.GetDC(), 0, 0, SRCCOPY);	
	}
}

void CPageCar::DrawPEIMarriedBCar(CDC *pDC, CAR_DATA *pCarData)
{
	if( CHECK_PEICALL1B(pCarData->DATA) )
	{
		pDC->BitBlt(399, 283, m_dcPEI3.Width(), m_dcPEI3.Height(), m_dcPEI3.GetDC(), 0, 0, SRCCOPY);	
	}

	if( CHECK_PEICALL2B(pCarData->DATA) )
	{
		pDC->BitBlt(214, 10, m_dcPEI4.Width(), m_dcPEI4.Height(), m_dcPEI4.GetDC(), 0, 0, SRCCOPY);		
	}

}

//bool CPageCar::IsErrorSingleCar(CAR_DATA *pCarData)
//{
//	return IsErrorMarriedACar(pCarData);
//}

bool CPageCar::IsErrorMarriedACar(CAR_DATA *pCarData)
{
	if( ( pCarData->DATA[1] & 0x0F ) ||
		( pCarData->DATA[2] & 0x0F ) ||
		( pCarData->DATA[3] & 0x07 ) ||
		( pCarData->DATA[4] & 0x0F ) ||
		( pCarData->DATA[5] & 0x0F ) ||
		( pCarData->DATA[6] & 0x08 ) ||
		( pCarData->DATA[8] & 0x09 )  )
	{
		return true;
	}

	return false;
}

bool CPageCar::IsErrorMarriedBCar(CAR_DATA *pCarData)
{
	if( ( pCarData->DATA[1] & 0xF0 ) ||
		( pCarData->DATA[2] & 0xF0 ) ||
		( pCarData->DATA[3] & 0x70 ) ||
		( pCarData->DATA[4] & 0xF0 ) ||
		( pCarData->DATA[5] & 0xF0 ) ||
		( pCarData->DATA[6] & 0x80 ) ||
		( pCarData->DATA[8] & 0x90 )  )
	{
		return true;
	}

	return false;
}

void CPageCar::OnTimer(UINT_PTR nIDEvent)
{
	if( m_nDisplayMode == 0 )
	{
		if( m_pParent->m_mgrPage.GetCurrentPage() == PAGE_ID_CHECK 
			||
			m_pParent->m_mgrPage.GetCurrentPage() == PAGE_ID_PEI )
		{
			UpdateCarList(true);
		}
	}
	else
	{
		Invalidate(false);
		RedrawWindow();
	}

	CDialog::OnTimer(nIDEvent);
}

void CPageCar::FreeResource()
{
	for(int i=0; i<12; i++) m_BtnCar[i].FreeResource();

	m_BtnSimulation.FreeResource();

	for(int i=0; i<5; i++) m_dcBG[i].FreeResource();

	m_dcArrow.FreeResource();

	m_dcFDI1.FreeResource();
	m_dcDPOA.FreeResource();
	m_dcVOIPC1.FreeResource();
	m_dcCCPA.FreeResource();
	m_dcCRA.FreeResource();
	m_dcPII1.FreeResource();
	m_dcPID21.FreeResource();
	
	m_dcPII3.FreeResource();
	//m_dcPID23.FreeResource();
	m_dcDPHA.FreeResource();

	m_dcFDI2.FreeResource();
	m_dcDPOB.FreeResource();
	m_dcVOIPC2.FreeResource();
	m_dcCCPB.FreeResource();
	m_dcCRB.FreeResource();
	m_dcPII2.FreeResource();
	m_dcPID22.FreeResource();

	m_dcPII4.FreeResource();
	//m_dcPID24.FreeResource();
	m_dcDPHB.FreeResource();

	m_dcPID11.FreeResource();;
	m_dcPID12.FreeResource();
	m_dcSDI1.FreeResource();
	m_dcPEI1.FreeResource();
	//m_dcCPO1.FreeResource();
	m_dcSDI2.FreeResource();

	m_dcPID15.FreeResource();
	m_dcPID16.FreeResource();
	m_dcSDI5.FreeResource();
	m_dcPEI4.FreeResource();
	//m_dcCPO3.FreeResource();
//	m_dcPEI5.FreeResource();
	m_dcSDI6.FreeResource();

	m_dcPID13.FreeResource();
	m_dcPID14.FreeResource();
	m_dcSDI3.FreeResource();
	m_dcPEI2.FreeResource();
	//m_dcCPO2.FreeResource();
	m_dcPEI3.FreeResource();
	m_dcSDI4.FreeResource();
	
	m_dcPID17.FreeResource();
	m_dcPID18.FreeResource();
	m_dcSDI7.FreeResource();
	//m_dcCPO4.FreeResource();
//	m_dcPEI6.FreeResource();

	m_dcCI.FreeResource();
	//m_dcTRIC11.FreeResource();
	//m_dcTRIC21.FreeResource();
}