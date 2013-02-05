unit USms;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, InvokeRegistry, StdCtrls, Rio, SOAPHTTPClient, Buttons, Mask,Shellapi,
  jpeg, ExtCtrls;

type
  TForm1 = class(TForm)
    HTTPRIO1: THTTPRIO;
    Button1: TButton;
    BitBtn1: TBitBtn;
    EditDD: TEdit;
    EditFone: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EditUsuario: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    MaskEdit1: TMaskEdit;
    LabelCaracter: TLabel;
    EditMensagem: TMemo;
    Button2: TButton;
    Button3: TButton;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure EditMensagemChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses

Prjsms;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  ObjSoap : SmsServicePort;
  Num : string;
begin
  ObjSoap := Httprio1 as SmsServicePort;
  Num := ObjSoap.creditos(EditUsuario.text,MaskEdit1.text);
  Button1.Caption :='Num_Cr�ditos:'+Copy(Num,9,3);

  Showmessage(Num);
  //Cretidos();
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
var
  ObjSoap : SmsServicePort;
  Num : string;
  Posicao : Integer;
  begin
  ObjSoap := Httprio1 as SmsServicePort;
  Num := ObjSoap.enviarSMS(EditDD.text,EditFone.text,EditMensagem.text,EditUsuario.text,MaskEdit1.text);
  Posicao:= Pos(',',Num);
  Delete(Num,Posicao,30);

//  Showmessage(Num);
   If Copy(Num,1,1) = '0' then
  Showmessage('Mensagem enviada!');
   if  Copy(Num,1,1) = '1' then
  Showmessage('Mensagem n�o enviada Tente Novamente!');
   if  Copy(Num,1,1) = '400' then
  Showmessage('O usu�rio ou senha fornecidas n�o s�o reconhecidas pelo sistema.!');
   if  Copy(Num,1,1) = '401' then
  Showmessage('O usu�rio foi autenticado com sucesso, entretanto n�o possui permiss�o para utiliza��o do servi�o.!');
   if  Copy(Num,1,1) = '402' then
  Showmessage('O usu�rio n�o tem nenhuma carga de cr�ditos ou todos os cr�ditos expiraram.');
   if  Copy(Num,1,1) = '403' then
  Showmessage('Os cr�ditos do usu�rio acabaram.');
   if  Copy(Num,1,1) = '404' then
  Showmessage('O envio de SenderID personalizado dever� ser contrato � parte dos cr�ditos.');
 if  Copy(Num,1,1) = '405' then
  Showmessage('Para enviar v�rios SMS de uma �nica vez o usu�rio dever� possuir cr�ditos suficientes antes de '+
'proceder o envio. No envio m�ltiplo, ou se envia todas, ou n�o se envia.');
 if  Copy(Num,1,1) = '500' then
  Showmessage('Os campos de usu�rio e senha n�o foram fornecidos.');
 if  Copy(Num,1,1) = '501' then
  Showmessage('O telefone deve ter 8 d�gitos e come�ar com [6-9]');




   Button1.Click;


   end;

procedure TForm1.EditMensagemChange(Sender: TObject);
  Var
   Numero : integer;
   texto : String;
   begin
     Texto := EditMensagem.Text;
     Numero := Length(EditMensagem.Text);
     LabelCaracter.Caption := IntToStr(Numero);
     If Numero > 160 then
     Begin
     Showmessage('Excedeu o Numero de Caracteres');
     Delete(Texto,Numero,Numero);
     EditMensagem.Text := texto;

     end;


     end;

procedure TForm1.Button2Click(Sender: TObject);
var
  ObjSoap : SmsServicePort;
  Num : string;
begin
  ObjSoap := Httprio1 as SmsServicePort;
  Num := ObjSoap.recursos(EditUsuario.text,MaskEdit1.text);
 // Button1.Caption :='Num_Cr�ditos:'+Copy(Num,9,3);

  Showmessage(Num);

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
ShellExecute(Handle, 'open', 'http://www.byjg.com.br/', '', '', 1);
end;

procedure TForm1.Image1Click(Sender: TObject);
begin
ShellExecute(Handle, 'open', 'http://www.jonaspneus.com.br/', '', '', 1);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    If Date > StrtoDate('15/01/2010') then
    Begin
    Showmessage('Inspirou o tempo do sistema. Contate:jonas@jonaspneus.com.br');
    Application.Terminate;
    end;
    end;

end.
