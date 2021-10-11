unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, MMSystem, Jpeg, ComCtrls;
  
type
  TForm1 = class(TForm)
    buffer: TImage;
    Timer1: TTimer;
    spr1: TImage;
    StartBtn: TButton;
    Bg: TImage;
    CurImg: TImage;
    blood: TImage;
    Timer2: TTimer;
    Spr2: TImage;
    Label1: TLabel;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    Procedure DrawSprite(c:Tcanvas; Sprite, mask: TImage; x,y,Frame:Integer);
    Procedure DrawBlood(c:Tcanvas; sprite, mask: TImage; x,y,Frame:Integer);
    Procedure DrawCursor;
    procedure Timer1Timer(Sender: TObject);
    procedure StartBtnClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
    Y: Integer);
    procedure FormClick(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    Procedure Initialize;
    Procedure StartGame;
    Procedure StopGame;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    private
    { Private-Deklarationen }
    public
    { Public-Deklarationen }
  end;
  
var
  Form1: TForm1;
  flipX1,flipY1,flipX2,FlipY2,hit1,hit2,Start: Boolean;
  SFrame1,SFrame2,BFrame,x1,y1,x2,y2,CurX,CurY,Counter,Hits,munition: Integer;

implementation

uses Unit2;
  
{$R *.DFM}

Procedure TForm1.Initialize;
begin
  SFrame1:=-1;
  SFrame2:=0;
  BFrame:=-1;
  Counter:=100;
  Munition:=100;
  Hits:=0;
end;

Procedure TForm1.StartGame;
begin
  Timer1.Enabled:=True;
  StartBtn.Caption:='Stop';
  Form1.Cursor:=crNone;
  if not start then IniTialize;
  Start:=True;
end;

Procedure Tform1.StopGame;
begin
  Timer1.Enabled:=False;
  StartBtn.Caption:='Go';
  Form1.Cursor:=crDefault;
end;

Procedure TForm1.DrawSprite(c:Tcanvas;sprite,mask:TImage;x,y,Frame:Integer);
begin
  BitBlt(c.Handle,x,y,48,35,mask.Canvas.Handle,Frame*48,35,SRCAnd);
  BitBlt(c.Handle,x,y,48,35,sprite.Canvas.Handle,Frame*48,0,SRCInvert);
end;

Procedure TForm1.DrawBlood(c:Tcanvas;sprite,mask:TImage;x,y,Frame:Integer);
begin
  BitBlt(c.Handle,x,y,20,20,mask.Canvas.Handle,Frame*20,20,SRCAnd);
  BitBlt(c.Handle,x,y,20,20,sprite.Canvas.Handle,Frame*20,0,SRCInvert);
end;

Procedure TForm1.DrawCursor;
begin
  BitBlt(buffer.canvas.Handle,CurX,CurY,20,20,CurImg.Canvas.Handle,0,20,SRCAnd);
  BitBlt(buffer.Canvas.Handle,CurX,CurY,20,20,CurImg.Canvas.Handle,0,0,SRCInvert);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Buffer.Canvas.Brush.Style:=bsClear;
  Buffer.Canvas.Font.Color:=clWhite;
  Buffer.Canvas.Font.Name:='Times New Roman';
  flipx1:=True;
  flipy1:=False;
  flipx2:=False;
  flipy2:=True;
  Randomize;
  x1:=Random(Form1.width); y1:=Random(Form1.Height);
  x2:=Random(Form1.width); y2:=Random(Form1.Height);
  Form1.KeyPreview:=True;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Sframe1:=SFrame1+1;
  SFrame2:=SFrame2+1;
  if hit1 or hit2 then BFrame:=BFrame+1;
  FormPaint(self);
  if SFrame1>=1 then SFrame1:=-1;
  if SFrame2>=1 then SFrame2:=-1;
  if BFrame>=5 then begin
  if hit1 then begin
  x1:=-Random(6)*5; y1:=Random(Form1.Height);
  Hit1:=False;
end;
if hit2 then begin
x2:=-Random(6)*5; y2:=Random(Form1.Height);
Hit2:=False;
end;
Hits:=Hits+1;
BFrame:=-1;
end;
end;

procedure TForm1.StartBtnClick(Sender: TObject);
begin
  if StartBtn.Caption='Go' then StartGame
  else StopGame;
end;

procedure TForm1.FormPaint(Sender: TObject);
var str:String;
begin
  BitBlt(buffer.canvas.Handle,0,0,bg.width,bg.height,Bg.Canvas.Handle,0,0,SRCCopy);
  Buffer.Canvas.Font.Size:=10;
  Buffer.Canvas.TextOut(15,12,'Time: '+IntToStr(counter));
  Buffer.Canvas.TextOut(100,12,'Kills: '+IntToStr(hits));
  Buffer.Canvas.TextOut(200,12,'Amunition: '+IntToStr(munition));
  Buffer.Canvas.TextOut(320,12,FormatDateTime('hh:mm:ss',Time));
  if ((Counter<=0) or (munition<=0)) and Start then begin
  StopGame;
  buffer.Canvas.Font.Size:=40;
  Str:='Lost!!';
  buffer.Canvas.TextOut((buffer.width-buffer.Canvas.TextWidth(Str))div 2,50,str);
  buffer.Canvas.Font.Size:=20;
  Str:='Press GO to Play!';
  buffer.Canvas.TextOut((buffer.width-buffer.Canvas.TextWidth(Str))div 2,150,str);
end else if not start then begin
Buffer.Canvas.Font.Size:=20;
Str:='Press GO to Play!';
Buffer.Canvas.TextOut((buffer.width-buffer.Canvas.TextWidth(Str))div 2,150,str);
end;
if not hit1 then begin
if timer1.Enabled then begin
if flipx1 then x1:=x1-4
else x1:=x1+4;
if flipy1 then y1:=y1-4
else y1:=y1+4;
if x1>=buffer.width-48 then flipx1:=True
else if x1<=0 then flipx1:=False;
if y1>=buffer.Height-35 then flipy1:=True
else if y1<=30 then flipy1:=False;
end;
DrawSprite(buffer.canvas,spr1,spr1,x1,y1,Sframe1);
end else DrawBlood(buffer.canvas,blood,blood,x1,y1,Bframe);

if not hit2 then begin
if Timer1.Enabled then begin
if flipx2 then x2:=x2-3
else x2:=x2+3;
if flipy2 then y2:=y2-3
else y2:=y2+3;
if x2>=buffer.width-48 then flipx2:=True
else if x2<=0 then flipx2:=False;
if y2>=buffer.Height-35 then flipy2:=True
else if y2<=30 then flipy2:=False;
end;
DrawSprite(buffer.canvas,spr2,spr2,x2,y2,Sframe2);
end else DrawBlood(buffer.canvas,blood,blood,x2,y2,Bframe);
DrawCursor;
Form1.Canvas.Draw(8,8,buffer.Picture.Graphic);
end;

procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
Y: Integer);
begin
  if Not Timer1.enabled then exit;
  CurX:=x-10;
  CurY:=y-10;
  if y>= buffer.Height then Form1.Cursor:=crDefault
  else Form1.Cursor:=crNone;
end;

procedure TForm1.FormClick(Sender: TObject);
begin
  //Here put sound and aim
  If Not Timer1.Enabled then exit;
  if (curX>=x1) and (curx<=x1+40) and
  (CurY>=y1) and (CurY<=y1+30) then begin
  SndPlaySound('shoot.wav',snd_nodefault or snd_async);
  hit1:=True;
end else if (curX>=x2) and (curx<=x2+40) and
(CurY>=y2) and (CurY<=y2+30) then begin
SndPlaySound('shoot.wav',snd_nodefault or snd_async);
hit2:=True;
end else begin
SndPlaySound('fire.wav',snd_nodefault or snd_async);
end;
munition:=munition-1;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  if timer1.enabled then Counter:=Counter-1
  else begin
  SFrame1:=SFrame1+1;
  SFrame2:=SFrame2+1;
  if SFrame1>1 then SFrame1:=0;
  if SFrame2>1 then SFrame2:=0;
  FormPaint(self);
end;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
Shift: TShiftState);
begin
  case key of
    VK_F1: startGame;
    VK_F3: StartBtnClick(self);
    VK_Escape: Application.Terminate;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  //stop and then start the game if it is running
  //or just show help window
  if StartBtn.Caption='Stop' then begin
  StopGame;
  HelpFrm.ShowModal;
  StartGame;
end else
HelpFrm.ShowModal;
end;

end.  
