unit UnPrev;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Spin, qrprntr,quickrpt,qrextra,
  Buttons, QRExport, Menus, ImgList, ToolWin;

type
  TImpressao = (pParcial,pTotal);

  TfrmPreview = class(TForm)
    QRPreview: TQRPreview;
    PrintDialog1: TPrintDialog;
    MainMenu1: TMainMenu;
    Opes1: TMenuItem;
    Imprimir1: TMenuItem;
    N1: TMenuItem;
    mniFechar: TMenuItem;
    ImageList1: TImageList;
    N2: TMenuItem;
    N3: TMenuItem;
    PrimeiraPgina1: TMenuItem;
    PginaAnterior1: TMenuItem;
    PrximaPgina1: TMenuItem;
    ltimapgina1: TMenuItem;
    Ajustarjanela1: TMenuItem;
    N1001: TMenuItem;
    Ajustarlarguradajanela1: TMenuItem;
    ToolBar1: TToolBar;
    btnSair: TToolButton;
    ToolButton1: TToolButton;
    sbFirstPage: TToolButton;
    sbPreviousPage: TToolButton;
    sbNextPage: TToolButton;
    sbLastPage: TToolButton;
    ToolButton8: TToolButton;
    Panel1: TPanel;
    Label2: TLabel;
    sePage: TSpinEdit;
    ToolButton2: TToolButton;
    Panel2: TPanel;
    Label4: TLabel;
    seZoom: TSpinEdit;
    ToolButton6: TToolButton;
    ZoomToFit: TToolButton;
    ZoomTo100: TToolButton;
    ZoomToWidth: TToolButton;
    ToolButton11: TToolButton;
    Print: TToolButton;
    procedure Init;
    procedure sePage1Change(Sender: TObject);
    procedure seZoom1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdExitClick(Sender: TObject);
    procedure QRPreviewPageAvailable(Sender: TObject; PageNum: Integer);
    procedure FormCreate(Sender: TObject);
    procedure sbFirstPage1Click(Sender: TObject);
    procedure sbPreviousPage1Click(Sender: TObject);
    procedure sbNextPage1Click(Sender: TObject);
    procedure sbLastPage1Click(Sender: TObject);
    procedure ZoomToFit1Click(Sender: TObject);
    procedure ZoomTo1001Click(Sender: TObject);
    procedure ZoomToWidth1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnSair1Click(Sender: TObject);
    procedure QRPreviewProgressUpdate(Sender: TObject; Progress: Integer);
    procedure Print1Click(Sender: TObject);
  private
    { Private declarations }
  public
    Impressao: TImpressao;
    iPgIni,iPgFim: LongInt;

    iInitZoom : integer;

    pQuickreport : TQuickRep;
    bPleaseInit : Boolean;
    sTitle : string;
    bCanPrint: boolean;

    function FormatCTB(rValor:real):string;
    function FormatCTB2(rValor:real):string;
    function Arredondar(valor1:Currency):Currency;
    function FormatCut(rValor:real):string;

    { Public declarations }
  end;

var
  frmPreview: TfrmPreview;

implementation

uses
   Printers;


{$R *.DFM}

procedure TfrmPreview.sePage1Change(Sender: TObject);
begin
  Application.ProcessMessages;
  // Controla os limites de navegação entre as páginas
  if sePage.Value > QRPreview.QRPrinter.PageCount then
    sePage.Value := QRPreview.QRPrinter.PageCount
  else if sePage.Value < 1 then
        sePage.Value := 1;

  // Posiciona a página do QrPreview
  QRPreview.PageNumber := sePage.Value;
end;

procedure TfrmPreview.seZoom1Change(Sender: TObject);
begin
  Application.ProcessMessages;
  // Atualiza o Preview com o paramêtro de zoom escolhido pelo usuário
  QRPreview.Zoom := seZoom.Value;
end;

procedure TfrmPreview.Init;
begin
  if bPleaseInit then
  begin
    sePage.MaxValue := QRPreview.QRPrinter.PageCount;
    sePage.MinValue := 1;
    sePage.Value    := 1;

    if iInitZoom = 0 then
    begin
      // Força o zoom para o 100%
      ZoomTo1001Click(Self);
    end
    else
    begin
      QRPreview.Zoom := iInitZoom;
    end;
    seZoom.Value   := QRPreview.Zoom;

    bPleaseInit    := False;
  end;
end;

procedure TfrmPreview.FormShow(Sender: TObject);
begin
  { Variável permite a execução da função init somente quando o formulário Preview dar
    realmente um ShowModal, afim de se não criar excessões pelo excesso de chamadas ao
    método OnPageAvaliable. Só neste momento, quando dar show, a função Init será executada
    a cada página exibida
  }
  bPleaseInit := True;

  if not bCanPrint then
  begin
    Print.Enabled := bCanPrint;
    Print.Visible := bCanPrint;
  end;
end;

procedure TfrmPreview.cmdExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPreview.QRPreviewPageAvailable(Sender: TObject;
  PageNum: Integer);
begin
  Init;
  sePage.MaxValue := PageNum;

  Caption := QRPreview.QRPrinter.Title + ' - ' +
                                     IntToStr(QRPreview.QRPrinter.PageCount) + ' página(s)';

  case QRPreview.QRPrinter.Status of
    mpReady: Caption := Caption + ' - Pronto';
    mpBusy: begin
              Caption := Caption + ' - Ocupado';
              QRPreview.Zoom:= 100;
            end;
    mpFinished: Caption := Caption + ' - Fim';
  end;

  Application.ProcessMessages;

  Print.enabled := QrPreview.QrPrinter.Status in [mpReady,mpFinished];
end;

procedure TfrmPreview.FormCreate(Sender: TObject);
begin
  iInitZoom := 0;

  bCanPrint := True;
end;

procedure TfrmPreview.sbFirstPage1Click(Sender: TObject);
begin
  Application.ProcessMessages;
  sePage.Value := 1;
  QRPreview.PageNumber:=sePage.Value;
end;

procedure TfrmPreview.sbPreviousPage1Click(Sender: TObject);
begin
  Application.ProcessMessages;
  if sePage.Value > 1 then
  begin
    sePage.Value := sePage.Value - 1;
    QRPreview.PageNumber:=sePage.Value;
  end;
end;

procedure TfrmPreview.sbNextPage1Click(Sender: TObject);
begin
  Application.ProcessMessages;
  if sePage.Value < QRPreview.QRPrinter.PageCount then
  begin
    sePage.Value := sePage.Value + 1;
    QRPreview.PageNumber:=sePage.Value;
  end;
end;

procedure TfrmPreview.sbLastPage1Click(Sender: TObject);
begin
  Application.ProcessMessages;
  sePage.Value := QRPreview.QRPrinter.PageCount;
  QRPreview.PageNumber:=sePage.Value;
end;

procedure TfrmPreview.ZoomToFit1Click(Sender: TObject);
begin
  Application.ProcessMessages;
  QRPreview.ZoomToFit;
  seZoom.Value:=QRPreview.Zoom;
  ZoomTo100.Down := false;
  ZoomToWidth.Down := false;
  ZoomToFit.Down := true;
end;

procedure TfrmPreview.ZoomTo1001Click(Sender: TObject);
begin
  Application.ProcessMessages;
  QRPreview.Zoom:=100;
  seZoom.Value:=QRPreview.Zoom;
  ZoomToFit.Down := false;
  ZoomToWidth.Down := false;
  ZoomTo100.Down := true;
end;

procedure TfrmPreview.ZoomToWidth1Click(Sender: TObject);
begin
  Application.ProcessMessages;
  QRPreview.ZoomToWidth;
  seZoom.Value:=QRPreview.Zoom;
  ZoomToFit.Down := false;
  ZoomTo100.Down := false;
  ZoomToWidth.Down := true;
end;

procedure TfrmPreview.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := QRPreview.QRPrinter.Status <> mpBusy;

  if CanClose then QRPreview.QRPrinter := nil;
end;

procedure TfrmPreview.btnSair1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmPreview.QRPreviewProgressUpdate(Sender: TObject;
  Progress: Integer);
begin
  Application.ProcessMessages;
end;

// Formato geral de valores no relatório
function TFrmPreview.FormatCTB(rValor:real):string;
begin
  if rValor >= 0 then
    Result := FormatFloat('#,##0.00',rValor)+' '
  else
    Result := FormatFloat('#,##0.00',Abs(rValor))+'-';
end;

function TFrmPreview.FormatCTB2(rValor:real):string;
begin
  if rValor >= 0 then
    Result := FormatFloat('#,##0.00',rValor)+' '
  else
    Result := '('+FormatFloat('#,##0.00',Abs(rValor))+')';
end;

function TFrmPreview.Arredondar(valor1:Currency):Currency;
var
  s: string;
begin
  s := FormatFloat('0.00',valor1);
  Result := StrToFloat(s);
end;

function TFrmPreview.FormatCut(rValor:real):string;
begin
  Result := FormatFloat('#,##0.00',Abs(rValor));
  Delete(Result, Length(Result)-2, Length(Result));

  if rValor >= 0 then Result := Result + ' '
                 else Result := Result + '-';
end;

procedure TfrmPreview.Print1Click(Sender: TObject);
var
  i, iCopias: Integer;
begin
 with PrintDialog1 do
 begin
   if Impressao = pParcial then // Tambem parcial
   begin
     Options := [poPageNums];

     MinPage := 1;
     MaxPage := QRPreview.QRPrinter.PageCount;

   end
   else
     Options := []; // Tambem Total

   if execute then
   begin
      pQuickReport.PrinterSettings.Copies := PrintDialog1.Copies;

      pQuickReport.PrinterSettings.PrinterIndex := Printer.PrinterIndex;

      if PrintRange = prAllPages then
      begin
        pQuickReport.PrinterSettings.FirstPage := 1;
        pQuickReport.PrinterSettings.LastPage  := QRPreview.QRPrinter.PageCount;

        iPgIni := 0;
        iPgFim := 0;

      end
      else
      begin
        pQuickReport.PrinterSettings.FirstPage := FromPage;
        pQuickReport.PrinterSettings.LastPage  := ToPage;

        iPgFim := 0;
        iPgIni := 0;
      end;

      if (Copies > 1)  and
         (Collate)     then
      begin
        iCopias := Copies;
        pQuickreport.PrinterSettings.Copies := 1;

        for i:=1 to iCopias do
        begin
          pQuickreport.Print;
        end;
      end
      else
        pQuickreport.Print;
   end;
 end;
end;

end.
