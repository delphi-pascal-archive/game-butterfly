unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;
  
type
  THelpFrm = class(TForm)
    OkBtn: TButton;
    Label1: TLabel;
    procedure OkBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    private
    { Private declarations }
    public
    { Public declarations }
  end;
  
var
  HelpFrm: THelpFrm;
  
implementation

uses Unit1;
  
{$R *.DFM}

procedure THelpFrm.OkBtnClick(Sender: TObject);
begin
  Close;
end;

procedure THelpFrm.FormCreate(Sender: TObject);
begin
  Label1.Caption:= 'Pour commencer a jouer appuyer sur Go o� F1.'+
  Chr(10)+Chr(13);
  Label1.Caption:= Label1.Caption+'Pour arreter le jeux appuyer sur Stop o� F3.'+
  Chr(10)+Chr(13);
  Label1.Caption:= Label1.Caption+'Pour Bouger il faut utiliser la souris.';
  
  Label1.Caption:= Label1.Caption+'Pour sortir du jeux appuyer sur ESC or Quitter.'+
  Chr(10)+Chr(13)+Chr(10)+Chr(13)+'Bon chance!';
end;

end.
