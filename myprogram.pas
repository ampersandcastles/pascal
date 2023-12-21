unit myprogram;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Controls, Forms,
  Dialogs, StdCtrls, DateUtils;

type
  TForm1 = class(TForm)
    bpmLabel: TLabel;
    startStopButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure startStopButtonClick(Sender: TObject);
  private
    clickTimes: TArray<TDateTime>;
    bpm: Integer;
    running: Boolean;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  clickTimes := [];
  bpm := 0;
  running := False;
  bpmLabel.Caption := 'BPM: N/A';
end;

procedure TForm1.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if running then
  begin
    clickTimes := clickTimes + [Now];
    CalculateBPM;
  end;
end;

procedure TForm1.startStopButtonClick(Sender: TObject);
begin
  if running then
  begin
    running := False;
    clickTimes := [];
    bpm := 0;
    bpmLabel.Caption := 'BPM: N/A';
    startStopButton.Caption := 'Start';
  end
  else
  begin
    running := True;
    startStopButton.Caption := 'Stop';
  end;
end;

procedure TForm1.CalculateBPM;
var
  timeDiff: TDateTime;
begin
  if Length(clickTimes) >= 2 then
  begin
    timeDiff := clickTimes[High(clickTimes)] - clickTimes[High(clickTimes) - 1];
    if timeDiff > 0 then
    begin
      bpm := Round(60 / SecondSpan(timeDiff));
      bpmLabel.Caption := Format('BPM: %d', [bpm]);
    end
    else
    begin
      bpmLabel.Caption := 'BPM: Max';
    end;
  end
  else
  begin
    bpmLabel.Caption := 'BPM: N/A';
  end;
end;

end.
