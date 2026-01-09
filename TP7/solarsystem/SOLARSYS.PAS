{$A+,B-,D+,E+,F-,G-,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+,Y+}
{$M 16384,0,655360}
uses graph,crt,Mousem,figures;
type figure=object
        end;
type pMyDesk=^tMyDesk;
     tMyDesk=object(DeskTop)
         constructor Init(Xn,Yn,Radn:integer;Coln:byte);
     end;
var
   MemBegin,MemEnd:longint;
   gd,gm:integer;
   Desk:pMyDesk;
Constructor tMyDesk.Init(Xn,Yn,Radn:integer;Coln:byte);
   var i,rr:integer;
       Ug1,Ug2:real;
       pp:pGroup;
   begin
     randomize;
     inherited Init(Xn,Yn,Radn,Coln);
     for i:=1 to random(6) do
       insert(new(pfreePoint,Init(random(640),random(480))));
     rr:=10;
     Ug1:=0;
     Ug2:=0;
     {Солнце}
     pp:=New(pKrug,Init(x+Round(rr*cos(Ug1)),
              y+Round(rr*sin(Ug1)),rr-10,20,14,Ug1));
     pp^.SetName('SUN');
     pp^.SetColorMy(14);
     insert(pp);
     Ug1:=Ug1+(2*Pi/10);
     {Меркурий}
     pp:=New(pKrug,Init(x+Round(rr*cos(Ug1)),
               y+Round(rr*sin(Ug1)),rr+30,8,4,1));
     pp^.SetName('Меркурий');
     pp^.SetSpeed(0.09);
     pp^.SetColorMy(4);
     pp^.insert(New(pPoint,Init(pp^.x+Round(20*cos(Ug2)),
                pp^.y+Round(20*sin(Ug2)),14,2)));
     insert(pp);
     Ug1:=Ug1+(2*Pi/10);
     Ug2:=Ug2+(2*Pi/10);
     {Венера}
     pp:=New(pKrug,Init(x+Round(rr*cos(Ug1)),
                 y+Round(rr*sin(Ug1)),rr+60,9,2,2));
     pp^.SetName('Венера');
     pp^.SetSpeed(0.07);
     pp^.SetColorMy(6);
     insert(pp);
     Ug1:=Ug1+(2*Pi/10);
     Ug2:=Ug2+(2*Pi/10);
     {Земля}
     pp:=New(pKrug,Init(x+Round(rr*cos(Ug1)),
                 y+Round(rr*sin(Ug1)),rr+94,10,6,3));
     pp^.SetName('Земля');
     pp^.SetColorMy(3);
     pp^.SetSpeed(0.05);
     pp^.insert(New(pPoint,Init(pp^.x+Round(20*cos(Ug2)),
                pp^.y+Round(20*sin(Ug2)),18,Ug2)));
     insert(pp);
     Ug1:=Ug1+(2*Pi/10);
     Ug2:=Ug2+(2*Pi/10);
     {Марс}
     pp:=New(pKrug,Init(x+Round(rr*cos(Ug1)),
                y+Round(rr*sin(Ug1)),rr+130,12,5,-6));
     pp^.SetName('Марс');
     pp^.SetColorMy(4);
     pp^.insert(New(pPoint,Init(pp^.x+Round(20*cos(Ug2)),
                pp^.y+Round(20*sin(Ug2)),17,3)));
     pp^.insert(New(pPoint,Init(pp^.x+Round(20*cos(Ug2)),
                pp^.y+Round(20*sin(Ug2)),17,5)));
     insert(pp);
     Ug1:=Ug1+(2*Pi/10);
     Ug2:=Ug2+(2*Pi/10);
     {Юпитер}
     pp:=New(pKrug,Init(x+Round(rr*cos(Ug1)),
                y+Round(rr*sin(Ug1)),rr+170,20,4,5));
     pp^.SetName('Юпитер');
     pp^.SetColorMy(7);
     insert(pp);
     Ug1:=Ug1+(2*Pi/10);
     Ug2:=Ug2+(2*Pi/10);
     {Сатурн}
     pp:=New(pKrug,Init(x+Round(rr*cos(Ug1)),
               y+Round(rr*sin(Ug1)),rr+210,13,13,4));
     pp^.SetName('Сатурн');
     pp^.SetColorMy(13);
     pp^.insert(New(pPoint,Init(pp^.x+Round(20*cos(Ug2)),
               pp^.y+Round(20*sin(Ug2)),30,2)));
     pp^.insert(New(pPoint,Init(pp^.x+Round(20*cos(Ug2)),
               pp^.y+Round(20*sin(Ug2)),19,4)));
     pp^.insert(New(pPoint,Init(pp^.x+Round(20*cos(Ug2)),
               pp^.y+Round(20*sin(Ug2)),25,7)));
     pp^.SetSpeed(0.02);
     insert(pp);
     Ug1:=Ug1+(2*Pi/10);
     Ug2:=Ug2+(2*Pi/10);
     {Уран}
     pp:=New(pKrug,Init(x+Round(rr*cos(Ug1)),
                y+Round(rr*sin(Ug1)),rr+247,15,13,1));
     pp^.SetName('Уран');
     pp^.Insert(New(pPoint,Init(pp^.x+Round(20*cos(Ug2)),
                pp^.y+Round(20*sin(Ug2)),21,Ug2)));
     insert(pp);
     {Нептун}
     pp:=New(pKrug,Init(x+Round(rr*cos(Ug1)),
                y+Round(rr*sin(Ug1)),rr+293,14,13,-7));
     pp^.SetName('Нептун');
     pp^.Insert(New(pPoint,Init(pp^.x+Round(20*cos(Ug2)),
                pp^.y+Round(20*sin(Ug2)),29,Ug2)));
     insert(pp);
end;

begin
      MemBegin:=MemAvail;
      gd:=VGA;gm:=VGAHi;
      InitGraph(gd,gm,'c:\dn\tp7\bin');
      ShowMouse;
      {Создать объект "Рабочая область"}
      New(Desk,Init(GetMaxX div 2, GetMaxY div 2, 300, 0));
      Desk^.Run;
      Dispose(Desk,Done);
      CloseGraph;
      MemEnd:=MemAvail;
      writeln('В начале:',MemBegin,' в конце:', MemEnd)
end.
