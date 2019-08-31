// Desenvolvido por Marcio Fernandes Cruz - Março / 2015
// E-mail: programador@marciofcruz.com
// https://www.linkedin.com/in/marciofcruz/


unit MFC.CV.Dispositivos;

interface

uses
  Winapi.Windows, Winapi.Messages, Winapi.ActiveX,
  System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.ComCtrls, Vcl.StdCtrls;

type
  ICreateDevEnum = interface(IUnknown)
    ['{29840822-5B84-11D0-BD3B-00A0C911CE86}']
    function CreateClassEnumerator(const clsidDeviceClass: TGUID; out ppEnumMoniker: IEnumMoniker; dwFlags: DWORD): HRESULT; stdcall;
  end;

type
  TCVDispositivos = class(TObject)
  private
  public
    procedure setLista(Lista: TStrings);
  end;

implementation

{ TCVDispositivos }

procedure TCVDispositivos.setLista(Lista: TStrings);
const
  CLSID_SystemDeviceEnum: TGUID = (D1: $62BE5D10; D2: $60EB; D3: $11D0; D4: ($BD, $3B, $00, $A0, $C9, $11, $CE, $86));
  IID_ICreateDevEnum: TGUID = '{29840822-5B84-11D0-BD3B-00A0C911CE86}';
  CLSID_VideoInputDeviceCategory: TGUID = (D1: $860BB310; D2: $5D01; D3: $11D0; D4: ($BD, $3B, $00, $A0, $C9, $11, $CE, $86));

  var
  pDevEnum: ICreateDevEnum;
  pClassEnum: IEnumMoniker;
  pMoniker: IMoniker;
  pPropertyBag: IPropertyBag;
  cFetched: ulong;
  name: OleVariant;

begin
  try
    CoCreateInstance(CLSID_SystemDeviceEnum, nil, CLSCTX_INPROC, IID_ICreateDevEnum, pDevEnum);

    pDevEnum.CreateClassEnumerator(CLSID_VideoInputDeviceCategory, pClassEnum, 0);

    Lista.Clear;

    Lista.Add('Auto detectar');

    while (pClassEnum.Next(1, pMoniker, @cFetched) = S_OK) do
    begin
      if S_OK = pMoniker.BindToStorage(nil, nil, IPropertyBag, pPropertyBag) then
      begin
        if S_OK = pPropertyBag.Read('FriendlyName', name, nil) then
        begin
          Lista.Add(name);
        end;
      end;
    end;
  finally
    pClassEnum := nil;
    pMoniker := nil;
    pDevEnum := nil;
    pPropertyBag := nil;
  end;
end;

end.
