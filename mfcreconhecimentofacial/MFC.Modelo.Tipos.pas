unit MFC.Modelo.Tipos;

interface

uses
  ocv.core.types_c, ocv.core_c, ocv.highgui_c, ocv.objdetect_c, ocv.utils,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Samples.Spin,
  Vcl.Menus, Vcl.ImgList;

type
  TConfigSQLServer = record
    Host, Banco, Usuario, Senha: String;
  end;

type
  pCtx = ^TCtx;

  TCtx = record
    MyCapture: pCvCapture; // Captura handle-Foto
    MyInputImage: pIplImage; // Entrada de imagem
    MyStorage: pCvMemStorage; // Storege de Memória
    TotalFaceDetect: Integer; // Total faces detectadas
  end;

  TPredicao = record
    Confianca: double;
    lab: Integer;
  end;

const
  cResourceFaceDetect = '..\resource\facedetectxml\';
  C_Width = 180;
  C_Height = 180;

  C_MaximoFotosDB = 20;

  C_FatorHistograma = 0.3;

implementation

end.
