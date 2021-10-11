unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, MPlayer;

type
  TForm1 = class(TForm)
    rejou: TButton;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Bevel1: TBevel;
    Timer1: TTimer;
    Timer2: TTimer;
    Timer3: TTimer;
    MediaPlayer1: TMediaPlayer;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    jeu1: TButton;
    jeu2: TButton;
    jeu3: TButton;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    Image13: TImage;
    Image14: TImage;
    Image15: TImage;
    Timer4: TTimer;
    procedure rejouClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer4Timer(Sender: TObject);
    procedure jeu1Click(Sender: TObject);
    procedure jeu2Click(Sender: TObject);
    procedure jeu3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure reel1;
    procedure reel2;
    procedure reel3;
    procedure checkwin;
    procedure clearbar;
  end;

var
  // Déclaration Globale nécessaire pour l'application

  Form1: TForm1;
  Reels: Array[1..16] of string = ('bell','cherry','melon','grape','orange','lemon2','cherry1','bell4','bar','melon1','cherry','grape','lemon','bell','orange','bar');
  Reels1: Array[1..16] of integer = (7,1,2,3,4,5,1,7,6,2,1,3,5,7,4,6);
  Reels2: Array[1..16] of integer = (0,0,0,0,0,2,1,4,0,1,0,0,0,0,0,0);
  num1,num2,num3 : integer;
  number1:integer = 16;
  number2:integer = 16;
  number3:integer = 16;
  time1:integer = 0;
  time2:integer = 0;
  time3:integer = 0;
  timer1length:integer = 0;
  timer2length:integer = 0;
  timer3length:integer = 0;
  holdleft:boolean = false;
  holdmid:boolean = false;
  holdright:boolean = false;
  offerahold:boolean = false;
  haswon:boolean = false;
  implementation

{$R *.dfm}

procedure TForm1.clearbar;
begin
     panel1.Color := clmaroon;
     panel1.Font.Color := clolive;
     panel2.Color := clmaroon;          //
     panel2.Font.Color := clolive;      //    Pour Rejouer la partie
     panel3.Color := clmaroon;          //
     panel3.Font.Color := clolive;      //    On Reinitialise Biensure
     panel4.Color := clmaroon;          //
     panel4.Font.Color := clolive;
     panel5.Color := clmaroon;
     panel5.Font.Color := clolive;
     panel6.Color := clmaroon;
     panel6.Font.Color := clolive;
     panel7.Color := clmaroon;
     panel7.Font.Color := clolive;
     panel8.Color := clmaroon;
     panel8.Font.Color := clolive;
end;

procedure TForm1.reel1;
  var next1,previous1:integer;
begin

 Next1 := num1 + 1;
 previous1 := num1 - 1;
  if next1 = 17 then next1 := 1;
  If previous1 = 0 then previous1 :=16;
                                    // charger les Images de la rangé
  image1.Picture.LoadFromFile('img\'+Reels[previous1]+'-dark.bmp');
  image4.Picture.LoadFromFile('img\'+Reels[num1]+'.bmp');
  image7.Picture.LoadFromFile('img\'+Reels[next1]+'-dark.bmp');

 end;

procedure TForm1.reel2;
  var next2,previous2:integer;
begin

 Next2 := num2 + 1;
 previous2 := num2 - 1;
  if next2 = 17 then next2 := 1;
  If previous2 = 0 then previous2 :=16;
                                      // Meme Comms
  image2.Picture.LoadFromFile('img\'+Reels[previous2]+'-dark.bmp');
  image5.Picture.LoadFromFile('img\'+Reels[num2]+'.bmp');
  image8.Picture.LoadFromFile('img\'+Reels[next2]+'-dark.bmp');

 end;

procedure TForm1.reel3;
  var next3,previous3:integer;
begin

 Next3 := num3 + 1;
 previous3 := num3 - 1;
  if next3 = 17 then next3 := 1;
  If previous3 = 0 then previous3 :=16;
                                 // Meme Commes
  image3.Picture.LoadFromFile('img\'+Reels[previous3]+'-dark.bmp');
  image6.Picture.LoadFromFile('img\'+Reels[num3]+'.bmp');
  image9.Picture.LoadFromFile('img\'+Reels[next3]+'-dark.bmp');

 end;

procedure TForm1.rejouClick(Sender: TObject);
var
timerand:integer;
begin
randomize;
timerand := random(151)+100;        //   Toujours aléatoire...
timer1length:= timerand;
timer2length:= timerand+100;
timer3length:= timerand+200;
clearbar;

if holdleft then begin holdleft := false; end else timer1.Enabled := true;

if holdmid then begin holdmid := false; end else timer2.Enabled := true;

if holdright then begin holdright := false; end else timer3.Enabled := true;

rejou.Enabled := false;
mediaplayer1.Close;
mediaplayer1.FileName := 'sfx\reelspin.wav';     // Le SON WAVE
mediaplayer1.Open;
mediaplayer1.Play;
jeu1.Enabled := false;
jeu2.Enabled := false;
jeu3.Enabled := false;
haswon := false;
offerahold := false;
end;

procedure TForm1.checkwin;
var barnum:integer;
begin
     if (Reels1[num1]=Reels1[num2]) And (Reels1[num2]=Reels1[num3]) then begin
        mediaplayer1.Close;
        mediaplayer1.FileName := 'sfx\win.wav';
        mediaplayer1.Open;
        mediaplayer1.Play;       // et Biensure le GAIN de la machine
        haswon:= true;           // à SOU
        if Reels1[num1] = 1 then ShowMessage('you won £1!');
        if Reels1[num1] = 2 then ShowMessage('you won £2!');
        if Reels1[num1] = 3 then ShowMessage('you won £3!');
        if Reels1[num1] = 4 then ShowMessage('you won £5!');
        if Reels1[num1] = 5 then ShowMessage('you won £10!');
        if Reels1[num1] = 6 then ShowMessage('you won £15!');
        if Reels1[num1] = 7 then ShowMessage('you won the jackpot £25!');
           timer4.Enabled := true;
     end
     else
     timer4.Enabled := true;
     barnum := Reels2[num1]+Reels2[num2]+Reels2[num3];
     if barnum = 1 then begin
     panel1.Color := clred;
     panel1.Font.Color := clyellow;
     panel2.Color := clmaroon;             // Et BIENSURE LES BONUS
     panel2.Font.Color := clolive;
     panel3.Color := clmaroon;
     panel3.Font.Color := clolive;
     panel4.Color := clmaroon;
     panel4.Font.Color := clolive;
     panel5.Color := clmaroon;
     panel5.Font.Color := clolive;
     panel6.Color := clmaroon;
     panel6.Font.Color := clolive;
     panel7.Color := clmaroon;
     panel7.Font.Color := clolive;
     panel8.Color := clmaroon;
     panel8.Font.Color := clolive;
     offerahold := false;
     end
   else
     if barnum = 2 then begin
     panel1.Color := clred;
     panel1.Font.Color := clyellow;
     panel2.Color := clred;
     panel2.Font.Color := clyellow;
     panel3.Color := clmaroon;
     panel3.Font.Color := clolive;
     panel4.Color := clmaroon;
     panel4.Font.Color := clolive;
     panel5.Color := clmaroon;
     panel5.Font.Color := clolive;
     panel6.Color := clmaroon;
     panel6.Font.Color := clolive;
     panel7.Color := clmaroon;
     panel7.Font.Color := clolive;
     panel8.Color := clmaroon;
     panel8.Font.Color := clolive;
     offerahold := false;
     end
   else
     if barnum = 3 then begin
     panel1.Color := clred;
     panel1.Font.Color := clyellow;
     panel2.Color := clred;
     panel2.Font.Color := clyellow;
     panel3.Color := clred;
     panel3.Font.Color := clyellow;
     panel4.Color := clmaroon;
     panel4.Font.Color := clolive;
     panel5.Color := clmaroon;
     panel5.Font.Color := clolive;
     panel6.Color := clmaroon;
     panel6.Font.Color := clolive;
     panel7.Color := clmaroon;
     panel7.Font.Color := clolive;
     panel8.Color := clmaroon;
     panel8.Font.Color := clolive;
     offerahold := false;
     end
   else
     if barnum = 4 then begin
     panel1.Color := clred;
     panel1.Font.Color := clyellow;
     panel2.Color := clred;
     panel2.Font.Color := clyellow;
     panel3.Color := clred;
     panel3.Font.Color := clyellow;
     panel4.Color := clred;
     panel4.Font.Color := clyellow;
     panel5.Color := clmaroon;
     panel5.Font.Color := clolive;
     panel6.Color := clmaroon;
     panel6.Font.Color := clolive;
     panel7.Color := clmaroon;
     panel7.Font.Color := clolive;
     panel8.Color := clmaroon;
     panel8.Font.Color := clolive;
     offerahold := true;
     end
   else
     if barnum = 5 then begin
     panel1.Color := clred;
     panel1.Font.Color := clyellow;
     panel2.Color := clred;
     panel2.Font.Color := clyellow;
     panel3.Color := clred;
     panel3.Font.Color := clyellow;
     panel4.Color := clred;
     panel4.Font.Color := clyellow;
     panel5.Color := clred;
     panel5.Font.Color := clyellow;
     panel6.Color := clmaroon;
     panel6.Font.Color := clolive;
     panel7.Color := clmaroon;
     panel7.Font.Color := clolive;
     panel8.Color := clmaroon;
     panel8.Font.Color := clolive;
     offerahold := false;
     end
   else
     if barnum = 6 then begin
     panel1.Color := clred;
     panel1.Font.Color := clyellow;
     panel2.Color := clred;
     panel2.Font.Color := clyellow;
     panel3.Color := clred;
     panel3.Font.Color := clyellow;
     panel4.Color := clred;
     panel4.Font.Color := clyellow;
     panel5.Color := clred;
     panel5.Font.Color := clyellow;
     panel6.Color := clred;
     panel6.Font.Color := clyellow;
     panel7.Color := clmaroon;
     panel7.Font.Color := clolive;
     panel8.Color := clmaroon;
     panel8.Font.Color := clolive;
     offerahold := false;
     end
   else
     if barnum = 7 then begin
     panel1.Color := clred;
     panel1.Font.Color := clyellow;
     panel2.Color := clred;
     panel2.Font.Color := clyellow;
     panel3.Color := clred;
     panel3.Font.Color := clyellow;
     panel4.Color := clred;
     panel4.Font.Color := clyellow;
     panel5.Color := clred;
     panel5.Font.Color := clyellow;
     panel6.Color := clred;
     panel6.Font.Color := clyellow;
     panel7.Color := clred;
     panel7.Font.Color := clyellow;
     panel8.Color := clmaroon;
     panel8.Font.Color := clolive;
     offerahold := false;
     end
   else
     if barnum = 8 then begin
     panel1.Color := clred;
     panel1.Font.Color := clyellow;       // Pour la couleurs des Bonus
     panel2.Color := clred;
     panel2.Font.Color := clyellow;
     panel3.Color := clred;
     panel3.Font.Color := clyellow;
     panel4.Color := clred;
     panel4.Font.Color := clyellow;
     panel5.Color := clred;
     panel5.Font.Color := clyellow;
     panel6.Color := clred;
     panel6.Font.Color := clyellow;
     panel7.Color := clred;
     panel7.Font.Color := clyellow;
     panel8.Color := clred;
     panel8.Font.Color := clyellow;
     offerahold := true;
     end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);

begin
 if number1 >= 2 then begin
 inc(number1,-1);
 num1 := number1;
 reel1;
 end
 else
 if number1 = 1 then begin
 number1 := 16;
 num1 := number1;
 reel1;
 end;
  if time1 <= timer1length-1 then begin
  inc(time1,1);
  end
  else
  if time1 = timer1length then begin
  time1 := 0;
  timer1.Enabled := false;
  mediaplayer1.Close;
  mediaplayer1.FileName := 'sfx\reelstop.wav';
  mediaplayer1.Open;
  mediaplayer1.Play;
  end;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
 if number2 >= 2 then begin
 inc(number2,-1);
 num2 := number2;
 reel2;
 end
 else
 if number2 = 1 then begin
 number2 := 16;
 num2 := number2;
 reel2;
 end;
 if time2 <= timer2length-1 then begin
  inc(time2,1);
  end
  else
  if time2 = timer2length then begin
  time2 := 0;
  timer2.Enabled := false;
  mediaplayer1.Close;
  mediaplayer1.FileName := 'sfx\reelstop.wav';
  mediaplayer1.Open;
  mediaplayer1.Play;
  end;
end;

procedure TForm1.Timer3Timer(Sender: TObject);
begin
 if number3 >= 2 then begin
 inc(number3,-1);
 num3 := number3;
 reel3;
 end
 else
 if number3 = 1 then begin
 number3 := 16;
 num3 := number3;
 reel3;
 end;
 if time3 <= timer3length-1 then begin
  inc(time3,1);
  end
  else
  if time3 = timer3length then begin
  time3 := 0;
  timer3.Enabled := false;
  mediaplayer1.Close;
  mediaplayer1.FileName := 'sfx\reelstop.wav';     //Appel E/S 
  mediaplayer1.Open;                               // pour le Wave
  mediaplayer1.Play;
  checkwin;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
timerand:integer;
begin
randomize;
timerand := random(151)+100;         // Rendre ça aléatoire puisque c'est
timer1length:= timerand;             // un jeux de Hasaed
timer2length:= timerand+100;         //
timer3length:= timerand+200;

timer1.Enabled := true;                //
timer2.Enabled := true;                //    L'Activation des Timers
timer3.Enabled := true;                //
form1.DoubleBuffered := true;          // Pour le Non clignotement de la forme
clearbar;                              // c'est Clair et net
end;

procedure TForm1.Timer4Timer(Sender: TObject);
  var next1,previous1,next2,previous2,next3,previous3,randhold:integer;
begin

 Next1 := num1 + 1;
 previous1 := num1 - 1;
  if next1 = 17 then next1 := 1;
  If previous1 = 0 then previous1 :=16;      // Pour indiquer l'image
 Next2 := num2 + 1;                          // à charger selon
 previous2 := num2 - 1;                      // un  TRI
  if next2 = 17 then next2 := 1;
  If previous2 = 0 then previous2 :=16;
 Next3 := num3 + 1;
 previous3 := num3 - 1;
  if next3 = 17 then next3 := 1;
  If previous3 = 0 then previous3 :=16;


  image1.Picture.LoadFromFile('img\'+Reels[previous1]+'.bmp');
  image4.Picture.LoadFromFile('img\'+Reels[num1]+'.bmp');        // Charger
  image7.Picture.LoadFromFile('img\'+Reels[next1]+'.bmp');       // Les Images

  image2.Picture.LoadFromFile('img\'+Reels[previous2]+'.bmp');
  image5.Picture.LoadFromFile('img\'+Reels[num2]+'.bmp');
  image8.Picture.LoadFromFile('img\'+Reels[next2]+'.bmp');

  image3.Picture.LoadFromFile('img\'+Reels[previous3]+'.bmp');
  image6.Picture.LoadFromFile('img\'+Reels[num3]+'.bmp');
  image9.Picture.LoadFromFile('img\'+Reels[next3]+'.bmp');

  timer4.Enabled := false;
  rejou.Enabled := true;

   if offerahold = false then begin     // deuxièmement chance de mettre la main ;-)
       Randhold := Random(110);
       if Randhold >= 90 then offerahold := true;
   end;

  if haswon = false then if offerahold then begin

  // button2.Enabled := true;
  // Détiens les Trois Handicapé
  // test due à la nécessité de contrôler pour une victoire
  // qui est mis en place à courir après trois arrêts Bobine!
  // si ce n'est même pas commencé, il ne peut pas arrêter :-(

   jeu2.Enabled := true;
   jeu3.Enabled := true;
   mediaplayer1.Close;
   mediaplayer1.FileName := 'sfx\HOLDOFFER.wav';
   mediaplayer1.Open;
   mediaplayer1.Play;
   rejou.SetFocus;
  end
  else
  haswon := false;
  end;
procedure TForm1.jeu1Click(Sender: TObject);
  var next3,previous3:integer;                // Boutton
begin                                         // pour Initialiser la rangé
                                              // et la fixer
 Next3 := num3 + 1;
 previous3 := num3 - 1;
  if next3 = 17 then next3 := 1;
  If previous3 = 0 then previous3 :=16;

  image3.Picture.LoadFromFile('img\'+Reels[previous3]+'-dark.bmp');
  image6.Picture.LoadFromFile('img\'+Reels[num3]+'.bmp');
  image9.Picture.LoadFromFile('img\'+Reels[next3]+'-dark.bmp');
  HoldRight:= true;
  jeu1.Enabled := false;
  mediaplayer1.Close;
  mediaplayer1.FileName := 'sfx\HOLD.wav';
  mediaplayer1.Open;
  mediaplayer1.Play;
end;

procedure TForm1.jeu2Click(Sender: TObject);    // Boutton
  var next2,previous2:integer;                  // pour Initialiser la rangé
begin                                           // et la fixer

 Next2 := num2 + 1;
 previous2 := num2 - 1;
  if next2 = 17 then next2 := 1;
  If previous2 = 0 then previous2 :=16;

  image2.Picture.LoadFromFile('img\'+Reels[previous2]+'-dark.bmp');
  image5.Picture.LoadFromFile('img\'+Reels[num2]+'.bmp');
  image8.Picture.LoadFromFile('img\'+Reels[next2]+'-dark.bmp');
  Holdmid:= true;
  jeu2.Enabled := false;
  mediaplayer1.Close;
  mediaplayer1.FileName := 'sfx\HOLD.wav';
  mediaplayer1.Open;
  mediaplayer1.Play;
end;

procedure TForm1.jeu3Click(Sender: TObject);        // Boutton
  var next1,previous1:integer;                      // pour Initialiser la rangé
begin                                               // et la fixer

 Next1 := num1 + 1;
 previous1 := num1 - 1;
  if next1 = 17 then next1 := 1;
  If previous1 = 0 then previous1 :=16;

  image1.Picture.LoadFromFile('img\'+Reels[previous1]+'-dark.bmp');
  image4.Picture.LoadFromFile('img\'+Reels[num1]+'.bmp');
  image7.Picture.LoadFromFile('img\'+Reels[next1]+'-dark.bmp');
  HoldLeft:= true;
  jeu3.Enabled := false;
  mediaplayer1.Close;
  mediaplayer1.FileName := 'sfx\HOLD.wav';
  mediaplayer1.Open;
  mediaplayer1.Play;
end;

end.
