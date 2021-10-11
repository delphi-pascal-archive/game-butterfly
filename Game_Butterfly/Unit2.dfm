object HelpFrm: THelpFrm
  Left = 277
  Top = 226
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'About'
  ClientHeight = 186
  ClientWidth = 318
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 12
    Top = 12
    Width = 297
    Height = 127
    AutoSize = False
    WordWrap = True
  end
  object OkBtn: TButton
    Left = 123
    Top = 156
    Width = 63
    Height = 26
    Cursor = crHandPoint
    Caption = 'Ok'
    TabOrder = 0
    OnClick = OkBtnClick
  end
end
