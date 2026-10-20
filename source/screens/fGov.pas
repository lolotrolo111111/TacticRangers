unit fGov;
// Unit bracket (inferred): .text 0x00524750..0x0052DE42; inclusive evidence, not full bounds. See docs/declarations.md#unit-coverage-and-address-brackets.

interface

uses GI_MessageLoop, aRanger, aPlanet, fPanelLoad, fPanelMain, fPanelPlanet, EC_Str, EC_BlockPar, EC_CacheFont, GI_Label, GI_PanelScrollBar, Types;

type
  TfGov = class(TMessageLoopGIWithMainPanel) // @size 0x13C
  public
    PlanetPanel: TfPanelPlanet; // @offset 0xD4
    LoadPanel: TfPanelLoad; // @offset 0xD8
    DialogText: WideString; // @offset 0xDC
    FormattedTextLength: Integer; // @offset 0xE0
    DialogRefreshTimer: PCallbackTimerGI; // @offset 0xE4
    NextChoiceTop: Integer; // @offset 0xE8
    QuestOffer: TQuest; // @offset 0xF0
    QuestNegotiationLevel: Integer; // @offset 0x114  -1..1.
    QuestRewardStep: Integer; // @offset 0x118
    QuestDurationStep: Integer; // @offset 0x11C

    ScriptDialogNames: TStringsEC; // @offset $120 Script names with borrowed TScript data.
    ScriptDialogCursor: Integer; // @offset $124
    AnimationRestartRequested: Boolean; // @offset $EC
    PlanetBattleMapId: Integer; // @offset $128
    PendingTransition: Integer; // @offset $12C 1=launch/exit to menu, 2=loss, 3=win, 4=cancel; launch is consumed on reopening.
    UseHdPortrait: Boolean; // @offset $130
    UseClassicPortrait: Boolean; // @offset $131
    PortraitPanel: TObjectGI; // @offset $134
    SavedChoiceScroll: Integer; // @offset $138

    constructor Create; // @addr 0x5247FC @ida "TfGov *__usercall $name@<eax>(void *SelfOrClass@<eax>, unsigned __int8 Allocate@<dl>);"
    destructor Destroy; override; // @addr 0x52487C @ida "void __usercall $name(TfGov *Self@<eax>, __int8 DestroyFlags@<dl>);"
    procedure InitializeLayout; override; // @addr $524D50
    procedure OnOpen; override; // @addr 0x525414 @note "Native diagnostic name: TfGov.BeforeRun."
    procedure AddChoice(Text: WideString; Value: Integer; Callback: TDialogChoiceEventGI); // @addr $527768
    procedure ClearDialogChoices; // @addr 0x5276EC
    procedure BuildGovernmentChoices(SkipScriptResponseText: Boolean); // @addr 0x5290DC @note "DL flag: true suppresses selecting/appending response text from the script-choice list; script execution and choice construction still run. Callers pass 0 or 1."
    procedure BuildQuestOfferChoices; // @addr 0x529E34
    procedure RequestQuest(Action: Integer); // @addr 0x52ADF4
    procedure MakeQuestEasier(Action: Integer); // @addr 0x52B518
    procedure MakeQuestHarder(Action: Integer); // @addr 0x52B810
    procedure AcceptQuest(Action: Integer); // @addr 0x52BB08
    procedure RejectQuest(Action: Integer); // @addr 0x52BD7C
    procedure PermanentlyDeclineQuest(Action: Integer); // @addr 0x52BE6C
    procedure AddScriptTakeoffChoice(Caption: WideString); // @addr $529BDC
    procedure AddScriptPlanetChoice(Caption: WideString); // @addr $529C40
    procedure AddScriptGoodsChoice(Caption: WideString); // @addr $529CA4
    procedure AddScriptShopChoice(Caption: WideString); // @addr $529D08
    procedure AddScriptHangarChoice(Caption: WideString); // @addr $529D6C
    procedure AddScriptRestartChoice(Caption: WideString); // @addr $52DD48
    procedure AddScriptNewsExitChoice(Caption: WideString); // @addr $529DD0
    procedure ContinueScriptDialog; // @addr $529AA8
    procedure RunScriptAnswerKeepingScroll(Answer: Integer); // @addr $52A130
    procedure RunScriptAnswer(Answer: Integer); // @addr $52A0BC
    procedure OnClose; override; // @addr $527230
    procedure EndTurnClicked(Sender: TObjectGI); // @addr $5272BC
    procedure ShipClicked(Sender: TObjectGI); // @addr $527374
    procedure RequestAnimationRestart; // @addr $5273EC
    procedure PortraitAnimationComplete(Sender: TObjectGI); // @addr $527400
    procedure UpdatePortraitAnimation(Talking: Boolean); // @addr $52743C
    procedure RememberChoiceScroll; // @addr $5276A0
    procedure ChoiceMouseEnter(Sender: TObjectGI); // @addr $527D34
    procedure ChoiceMouseLeave(Sender: TObjectGI); // @addr $527D54
    procedure ChoiceMouseDown(Sender: TObjectGI; KeyState: Cardinal; Point: TPoint); // @addr $527D74 @ida "void __userpurge $name(TfGov *Self@<eax>, TObjectGI *Sender@<edx>, unsigned int KeyState@<ecx>, TPoint *Point@<^0>);"
    procedure ChoiceMouseUp(Sender: TObjectGI; KeyState: Cardinal; Point: TPoint); // @addr $527DF4 @ida "void __userpurge $name(TfGov *Self@<eax>, TObjectGI *Sender@<edx>, unsigned int KeyState@<ecx>, TPoint *Point@<^0>);"
    procedure RestartTextPresentation(RestartAnimation: Boolean); // @addr $527F14
    procedure AdvanceTextPresentation(Timer: PCallbackTimerGI; UserData: Integer); // @addr $527FC0
    procedure ProcessMouseWheel(KeyState: Cardinal; Point: TPoint; Delta: Integer); override; // @addr $528434 @ida "void __userpurge $name(TfGov *Self@<eax>, unsigned int KeyState@<edx>, TPoint *Point@<ecx>, int Delta@<^0>);"
    function CreateDialogObject(LabelControl: TLabelGI; Item: PFontObjectEC): TObjectGI; // @addr $52852C
    procedure AddMessageClicked(Sender: TObjectGI); // @addr $528840
    procedure StartScriptMessage(Action: Integer); // @addr $52A084
    procedure RunInjectedAnswerKeepingScroll(Answer: Integer); // @addr $52DCF0
    procedure RunScriptTakeoffAnswer(Answer: Integer); // @addr $52A154
    procedure RunScriptPlanetAnswer(Answer: Integer); // @addr $52A210
    procedure RunScriptGoodsAnswer(Answer: Integer); // @addr $52A244
    procedure RunScriptShopAnswer(Answer: Integer); // @addr $52A278
    procedure RunScriptHangarAnswer(Answer: Integer); // @addr $52A2AC
    procedure RunScriptNewsExitAnswer(Answer: Integer); // @addr $52A2E0
    procedure RunScriptRestartAnswer(Answer: Integer); // @addr $52DD14
    procedure ReturnToPlanet(Action: Integer); // @addr $52DADC
    procedure ExitGovernment(Action: Integer); // @addr $52DB04
    procedure ExecuteUiCode(Block: TBlockParEC; Key: Cardinal); override; // @addr $52DDD0
    procedure MainPanelKeyDown(Sender: TObjectGI; Key: Cardinal); // @addr $528610
    procedure SelectMusic; override; // @addr $5289B0
    procedure DeclinePlanetBattle(Action: Integer); // @addr $52BFB4
    procedure ConfirmDeclineAllPlanetBattles(Action: Integer); // @addr $52C148
    procedure DeclineAllPlanetBattles(Action: Integer); // @addr $52C300
    procedure CancelDeclineAllPlanetBattles(Action: Integer); // @addr $52C3D8
    procedure CancelPrisonBail(Action: Integer); // @addr $52DA28
    procedure ShowPlanetBattleSupport(Action: Integer); // @addr $52C4A0
    procedure StartPlanetBattleWithoutSupport(Action: Integer); // @addr $52C7FC
    procedure StartPlanetBattleWithReinforcements(Action: Integer); // @addr $52C8DC
    procedure StartPlanetBattleWithBombardment(Action: Integer); // @addr $52C9BC
    procedure DeclineBattleAndLeave(Action: Integer); // @addr $52CA9C
    procedure ChoosePrisonInsteadOfBattle(Action: Integer); // @addr $52CBCC
    procedure EnterPrison(Action: Integer); // @addr $52A314
    procedure ShowMapOffer(Action: Integer); // @addr $52CEDC
    procedure BuyMap(Action: Integer); // @addr $52D190
    procedure DeclineMapOffer(Action: Integer); // @addr $52D330
    procedure ShowPrisonBail(Action: Integer); // @addr $52D3F8
    procedure PayPrisonBail(Action: Integer); // @addr $52D888
    procedure ContinueAfterPrison(Action: Integer); // @addr $52A528
    procedure ShowBribeOffer(Action: Integer); // @addr $52A668
    procedure PayBribe(Action: Integer); // @addr $52AA40
    procedure DeclineBribe(Action: Integer); // @addr $52AD28
    procedure AddBuiltinGovernmentChoices; // @addr $5297FC
    procedure RefreshGovernmentDialog; // @addr $528B34
    procedure RunInjectedAnswer(Answer: Integer); // @addr $52DB2C
  end;

  TStrategicScreen = class(TMessageLoopGI) // @size $EC
  public
    Gov: TfGov; // @offset $D0
    SelectedPlanet: Integer; // @offset $D4
    PlanetList: TPanelScrollBarGI; // @offset $D8
    Details: TLabelGI; // @offset $DC
    Status: TLabelGI; // @offset $E0
    InitialPlanet: TPlanet; // @offset $E4 Mod-added initial selection.
    DirectMode: Boolean; // @offset $E8 Mod-added remote view flag.
    procedure OnOpen; override; // @addr $F0000010 @note "Mod-added screen."
    procedure ProcessMouseWheel(KeyState: Cardinal; Point: TPoint; Delta: Integer); override; // @addr $F0000011 @ida "void __userpurge $name(TStrategicScreen *Self@<eax>, unsigned int KeyState@<edx>, TPoint *Point@<ecx>, int Delta@<^0>);"
    procedure SelectPlanet(Sender: TObjectGI; KeyState: Cardinal; Point: TPoint); // @addr $F0000012 @ida "void __userpurge $name(TStrategicScreen *Self@<eax>, TObjectGI *Sender@<edx>, unsigned int KeyState@<ecx>, TPoint *Point@<^0>);"
    procedure ActionClicked(Sender: TObjectGI; KeyState: Cardinal; Point: TPoint); // @addr $F0000013 @ida "void __userpurge $name(TStrategicScreen *Self@<eax>, TObjectGI *Sender@<edx>, unsigned int KeyState@<ecx>, TPoint *Point@<^0>);"
    procedure CloseClicked(Sender: TObjectGI); // @addr $F0000014
    procedure RefreshDetails; // @addr $F0000015
  end;

procedure OpenStrategicPlanet(Parent: TMessageLoopGI; Planet: TPlanet); // @addr $F0000030 @note "Mod-added remote camera management."

var
  GovernmentBattleDifficulty: Integer; // @addr $889A34 Native battle launch selector, 1..3.

implementation

uses Classes, SysUtils, Math, Windows, Globals, GlobalsV, GR_Main, GI_Main, GI_Panel, GI_Image, GI_GAI, GI_PanelScrollBar, GI_ScrollBar, GI_GraphButton, GI_Window, GI_Frame, fListBox, aGalaxy, aGalaxyStruct, aGroup, aConst, aShip, aPlayer, aPlanet, aScript, aMyFunction, aSaveLoad, fSaveManager, fHangar, fShip2, fTalk, ThreadCalc, aCalc, aItem, Achievements, aPirate, aNormalShip, aWarrior, Robot, fPlanetQuest;

var DirectStrategicCall: Boolean = False;

{ @routine $F0000030 OpenStrategicPlanet }
procedure OpenStrategicPlanet(Parent: TMessageLoopGI; Planet: TPlanet);
var Screen: TStrategicScreen; State: TCursorStateGI;
begin
  if (Parent = nil) or (Planet = nil) or not Planet.IsCoalitionOwned then Exit;
  Parent.RootUiObject.NativeHook50;
  Parent.CaptureCursorState(@State);
  Parent.SetCursorActive(False);
  Parent.DrawQueuedUpdateRects;
  CaptureScreenBackground(False, 0);
  Screen := TStrategicScreen.Create;
  try
    Screen.ParentLoop := Parent;
    Parent.ChildLoop := Screen;
    Screen.InitializeDefaults;
    Screen.Gov := GovernmentScreen;
    Screen.InitialPlanet := Planet;
    Screen.DirectMode := True;
    Screen.Run;
  finally
    Parent.ChildLoop := nil;
    Screen.Free;
    Parent.InvalidateViewport;
    Parent.RestoreCursorState(@State);
    Parent.UpdateCursorPosition;
    Parent.RootUiObject.NativeHook48;
  end;
end;
{ @end $F0000030 }

{ @routine $F0000010 TStrategicScreen_OnOpen }
procedure TStrategicScreen.OnOpen;
var Window: TWindowGI; CloseButton: TGraphButtonGI; Title, LabelControl: TLabelGI;
  Frame: TFrameGI; W, H, LeftWidth, RightX, RightWidth, I, Y: Integer; Planet: TPlanet;
  procedure AddAction(Caption: WideString; Action, Column, Row: Integer);
  var ButtonLabel: TLabelGI; Border: TFrameGI; X, Top, ButtonWidth: Integer;
  begin
    ButtonWidth := (RightWidth - 12) div 2;
    X := RightX + Column * (ButtonWidth + 8);
    Top := GiScalePixels(255) + Row * GiScalePixels(30);
    Border := TFrameGI.Create(ContentPanel);
    Border.SetPosition(Classes.Point(X, Top));
    Border.SetSize(Classes.Point(ButtonWidth, GiScalePixels(25)));
    Border.SetKind(fkRect);
    Border.SetColor(CurrentPixelFormat.PackRgbBytes(45, 65, 95));
    Border.SetFillColor(CurrentPixelFormat.PackRgbBytes(222, 230, 235));
    Border.SetFill(True);
    ButtonLabel := TLabelGI.Create(ContentPanel);
    ButtonLabel.SetPosition(Classes.Point(X + 3, Top));
    ButtonLabel.SetSize(Classes.Point(ButtonWidth - 6, GiScalePixels(25)));
    ButtonLabel.SetTextAlignX(taxCenter);
    ButtonLabel.SetTextAlignY(tayCenter);
    ButtonLabel.SetFontName(NormalFontName);
    ButtonLabel.SetTextColor(CurrentPixelFormat.PackRgbBytes(0, 40, 140));
    ButtonLabel.SetText(Caption);
    ButtonLabel.UserValue := Action;
    ButtonLabel.LeftButtonDownCallback := ActionClicked;
  end;
begin
  W := Min(GameScreenWidth - 20, GiScalePixels(850));
  H := Min(GameScreenHeight - 20, GiScalePixels(600));
  LeftWidth := (W - GiScalePixels(55)) * 43 div 100;
  RightX := LeftWidth + GiScalePixels(35);
  RightWidth := W - RightX - GiScalePixels(20);
  Window := TWindowGI.Create(ContentPanel);
  Window.SetDepth(1);
  Window.SetConfigPath('Style.Window.' + GiResourceSuffix + 'MessageBox');
  Window.SetSize(Classes.Point(W, H));
  Window.UpdateAutoGeometry;
  Title := TLabelGI.Create(ContentPanel);
  Title.SetPosition(Classes.Point(0, GiScalePixels(25)));
  Title.SetSize(Classes.Point(W, GiScalePixels(25)));
  Title.SetTextAlignX(taxCenter); Title.SetTextAlignY(tayCenter);
  Title.SetFontName(NormalBoldFontName);
  Title.SetTextColor(CurrentPixelFormat.PackRgbBytes(0, 0, 0));
  Title.SetText('Стратегическое командование — планеты и флоты');
  PlanetList := TPanelScrollBarGI.Create(ContentPanel);
  PlanetList.SetDepth(0);
  PlanetList.SetUnlimitedWorldEnabled(False);
  PlanetList.SetScrollbarsOutside(True);
  PlanetList.SetVerticalScrollBarConfigPath('Style.ScrollBar.' + GiResourceSuffix + 'PQS2');
  PlanetList.SetHorizontalScrollbarEnabled(False);
  PlanetList.SetVerticalScrollbarEnabled(True);
  PlanetList.SetPosition(Classes.Point(GiScalePixels(20), GiScalePixels(65)));
  PlanetList.SetSize(Classes.Point(LeftWidth, H - GiScalePixels(120)));
  PlanetList.ScrollAxis := psaVertical;
  Frame := TFrameGI.Create(ContentPanel);
  Frame.SetPosition(Classes.Point(GiScalePixels(19), GiScalePixels(64)));
  Frame.SetSize(Classes.Point(LeftWidth + 2, H - GiScalePixels(118)));
  Frame.SetKind(fkRect); Frame.SetColor(CurrentPixelFormat.PackRgbBytes(0, 0, 0));
  Y := 0; SelectedPlanet := -1;
  for I := 0 to Galaxy.Planets.Count - 1 do begin
    Planet := TPlanet(Galaxy.Planets[I]);
    if not Planet.IsCoalitionOwned then Continue;
    if SelectedPlanet < 0 then SelectedPlanet := I;
    LabelControl := TLabelGI.Create(PlanetList);
    LabelControl.SetPositionModeW(True);
    LabelControl.SetPosition(Classes.Point(2, Y));
    LabelControl.SetSize(Classes.Point(LeftWidth - GiScalePixels(6), GiScalePixels(24)));
    LabelControl.SetFontName(NormalFontName);
    LabelControl.SetTextAlignY(tayCenter);
    LabelControl.SetTextColor(CurrentPixelFormat.PackRgbBytes(0, 40, 150));
    LabelControl.SetText(Planet.GetFullName(' ') + ' / ' + Planet.CurrentStar.Name);
    LabelControl.UserValue := I;
    LabelControl.LeftButtonDownCallback := SelectPlanet;
    Inc(Y, GiScalePixels(24));
  end;
  if (InitialPlanet <> nil) and InitialPlanet.IsCoalitionOwned then
    SelectedPlanet := Galaxy.Planets.IndexOf(InitialPlanet);
  PlanetList.UpdateScrollbarPlacement; PlanetList.UpdateScrollRanges;
  PlanetList.VerticalScrollBar.SetSmallChange(GiScalePixels(24));
  PlanetList.VerticalScrollBar.SetLargeChange(PlanetList.ClientSize.Y);
  PlanetList.VerticalScrollBar.SetPageSize(PlanetList.ClientSize.Y);
  Details := TLabelGI.Create(ContentPanel);
  Details.SetPosition(Classes.Point(RightX, GiScalePixels(65)));
  Details.SetSize(Classes.Point(RightWidth, GiScalePixels(180)));
  Details.SetWordWrapEnabled(True); Details.SetFontName(NormalFontName);
  Details.SetTextColor(CurrentPixelFormat.PackRgbBytes(0, 0, 0));
  AddAction('Продовольствие', 1, 0, 0);
  AddAction('Двигатели +1', 2, 1, 0);
  AddAction('Защита и оружие +1', 3, 0, 1);
  AddAction('Построить защитника', 4, 1, 1);
  AddAction('Научная ветка', 5, 0, 2);
  AddAction('Промышленная ветка', 6, 1, 2);
  AddAction('Поднять гарнизон', 7, 0, 3);
  AddAction('Вернуть гарнизон', 8, 1, 3);
  AddAction('Отправить 1 корабль', 20, 0, 4);
  AddAction('Отправить флот', 21, 1, 4);
  AddAction('Отозвать флоты', 9, 0, 5);
  Status := TLabelGI.Create(ContentPanel);
  Status.SetPosition(Classes.Point(RightX, GiScalePixels(440)));
  Status.SetSize(Classes.Point(RightWidth, H - GiScalePixels(490)));
  Status.SetWordWrapEnabled(True); Status.SetFontName(NormalFontName);
  Status.SetTextColor(CurrentPixelFormat.PackRgbBytes(0, 40, 130));
  Status.SetText('Выберите планету и действие.');
  CloseButton := TGraphButtonGI.Create(ContentPanel);
  CloseButton.SetDepth(0);
  CloseButton.SetImageNormalPath('GI,Bm.FormMessageBox.' + GiResourceSuffix + 'CancelN');
  CloseButton.SetImageNormalActivePath('GI,Bm.FormMessageBox.' + GiResourceSuffix + 'CancelA');
  CloseButton.SetImageDownPath('GI,Bm.FormMessageBox.' + GiResourceSuffix + 'CancelD');
  CloseButton.SetSize(CloseButton.GetMaxStateImageSize);
  CloseButton.SetPosition(Classes.Point(W - CloseButton.ClientSize.X - GiScalePixels(20), H - CloseButton.ClientSize.Y - GiScalePixels(20)));
  CloseButton.HitKind := gbhRect; CloseButton.UpOnlyDown := True;
  CloseButton.UpdateStateImagePlacement; CloseButton.UpdateStateVisuals;
  CloseButton.UpCallback := CloseClicked;
  ViewportRect := Classes.Rect((GameScreenWidth-W) div 2, (GameScreenHeight-H) div 2, (GameScreenWidth+W) div 2, (GameScreenHeight+H) div 2);
  ContentPanel.SetPosition(ViewportRect.TopLeft); ContentPanel.SetSize(Classes.Point(W,H));
  ContentPanel.UpdateAbsolutePosition; ContentPanel.UpdateSubtreeHitBounds;
  RefreshDetails;
end;
{ @end $F0000010 }

{ @routine $F0000011 TStrategicScreen_ProcessMouseWheel }
procedure TStrategicScreen.ProcessMouseWheel(KeyState: Cardinal; Point: TPoint; Delta: Integer);
begin
  with PlanetList.VerticalScrollBar do
    if Delta = WHEEL_DELTA then SetPosition(Position - SmallChange)
    else if Delta = -WHEEL_DELTA then SetPosition(Position + SmallChange);
end;
{ @end $F0000011 }

{ @routine $F0000012 TStrategicScreen_SelectPlanet }
procedure TStrategicScreen.SelectPlanet(Sender: TObjectGI; KeyState: Cardinal; Point: TPoint);
begin
  SelectedPlanet := Sender.UserValue;
  Status.SetText('Планета выбрана.');
  RefreshDetails;
end;
{ @end $F0000012 }

{ @routine $F0000015 TStrategicScreen_RefreshDetails }
procedure TStrategicScreen.RefreshDetails;
var Planet: TPlanet; Ship: TShip; Group: TGroup; I, FleetCount, Travelling, AtTarget, Returning, Payload, Code: Integer; Text: WideString;
begin
  if (SelectedPlanet < 0) or (SelectedPlanet >= Galaxy.Planets.Count) then begin Details.SetText('Нет доступных планет.'); Exit; end;
  Planet := TPlanet(Galaxy.Planets[SelectedPlanet]);
  FleetCount := 0; Travelling := 0; AtTarget := 0; Returning := 0;
  for I := 0 to Planet.Warriors.Count - 1 do begin
    Ship := TShip(Planet.Warriors[I]);
    if Ship.LiberationGroup = nil then Continue;
    Group := TGroup(Ship.LiberationGroup);
    if not Group.IsStrategicFleet then Continue;
    Inc(FleetCount);
    if Group.Route[2].WaitMode = 42 then Inc(Returning)
    else if not Ship.IsOutsideStarSpace and (Ship.CurrentStar = Group.Route[3].Target) then Inc(AtTarget)
    else Inc(Travelling);
  end;
  Text := Planet.GetFullName(' ') + ' / ' + Planet.CurrentStar.Name + #13#10 +
    'Бюджет: ' + IntToStr(Planet.Money) + ' cr.; население: ' + IntToStr(Planet.Population) + #13#10 +
    'Гарнизон: ' + IntToStr(Planet.Warriors.Count) + '; назначено во флот: ' + IntToStr(FleetCount) + #13#10 +
    'В пути: ' + IntToStr(Travelling) + '; в системе: ' + IntToStr(AtTarget) + '; возвращаются: ' + IntToStr(Returning) + #13#10 +
    'Двигатели L' + IntToStr(Planet.InventionLevels[2]) + '; защита и оружие L' + IntToStr(Planet.InventionLevels[7]);
  if (Planet.ReservedSaveValue >= StrategyOrderMarker) and (Planet.ReservedSaveValue < StrategyOrderMarker + 500000000) then begin
    Payload := Planet.ReservedSaveValue - StrategyOrderMarker;
    Code := Payload mod StrategyOrderCodeFactor;
    if Code <> 0 then Text := Text + #13#10 + 'Заказ завершится в день ' + IntToStr(Payload div StrategyOrderTurnFactor)
    else Text := Text + #13#10 + 'Очередь свободна.';
  end else Text := Text + #13#10 + 'Очередь свободна.';
  Details.SetText(Text);
end;
{ @end $F0000015 }

{ @routine $F0000013 TStrategicScreen_ActionClicked }
procedure TStrategicScreen.ActionClicked(Sender: TObjectGI; KeyState: Cardinal; Point: TPoint);
var Action, I, J, N, Selection, FleetMode: Integer; Planet: TPlanet; Star: TStar; Ship: TShip; Items, StarIndices: TList; Name: PWideString;
begin
  if (SelectedPlanet < 0) or (SelectedPlanet >= Galaxy.Planets.Count) then Exit;
  Planet := TPlanet(Galaxy.Planets[SelectedPlanet]);
  if not Planet.IsCoalitionOwned then begin Status.SetText('Планета больше не принадлежит Коалиции.'); Exit; end;
  Action := Sender.UserValue;
  if Action < 20 then begin
    DirectStrategicCall := DirectMode;
    try
      Gov.RunInjectedAnswer(-20000 - SelectedPlanet * 10 - Action);
    finally
      DirectStrategicCall := False;
    end;
  end
  else begin
    FleetMode := Action - 20;
    Items := TList.Create; StarIndices := TList.Create;
    try
      for I := 0 to Galaxy.Stars.Count - 1 do begin
        if I >= 1000 then Break;
        Star := TStar(Galaxy.Stars[I]);
        if Star = Planet.CurrentStar then Continue;
        N := 0;
        for J := 0 to Planet.Warriors.Count - 1 do begin
          Ship := TShip(Planet.Warriors[J]);
          if ((Ship.CurrentPlanet = Planet) or (Ship.InNormalSpace and (Ship.CurrentStar = Planet.CurrentStar) and (Ship.Order in [soNone, soMove]))) and
            (Ship.ScriptShip = nil) and (Ship.AbsoluteScriptOrder = 0) and (Ship.LiberationGroup = nil) and
            (Ship.GetFuelLimitedJumpRange >= Round(PointDistance(Planet.CurrentStar.Position, Star.Position))) then Inc(N);
        end;
        if N > 0 then begin
          New(Name); Name^ := Star.Name + ' — кораблей: ' + IntToStr(N);
          Items.Add(Name); StarIndices.Add(Pointer(I));
        end;
      end;
      if Items.Count = 0 then begin Status.SetText('Нет систем, доступных для прямого прыжка свободных кораблей.'); Exit; end;
      Selection := -1;
      ShowListDialog(Self, Selection, 'Система назначения', Items, 0, 0);
      if (Selection < 0) or (Selection >= Items.Count) then Exit;
      I := Integer(StarIndices[Selection]);
      DirectStrategicCall := DirectMode;
      try
        Gov.RunInjectedAnswer(-100000 - SelectedPlanet * 2000 - FleetMode * 1000 - I);
      finally
        DirectStrategicCall := False;
      end;
    finally
      for I := 0 to Items.Count - 1 do begin Name := Items[I]; Dispose(Name); end;
      StarIndices.Free; Items.Free;
    end;
  end;
  Status.SetText(Gov.DialogText);
  RefreshDetails;
end;
{ @end $F0000013 }

{ @routine $F0000014 TStrategicScreen_CloseClicked }
procedure TStrategicScreen.CloseClicked(Sender: TObjectGI);
begin
  RequestClose(1);
end;
{ @end $F0000014 }

{ @routine $5247FC TfGov_Create }
constructor TfGov.Create;
begin
  inherited Create;
  PlanetPanel := TfPanelPlanet.Create;
  ScriptDialogNames := TStringsEC.Create;
  LoadPanel := TfPanelLoad.Create;
end;
{ @end $5247FC }

{ @routine $52487C TfGov_Destroy }
destructor TfGov.Destroy;
begin
  if LoadPanel <> nil then begin LoadPanel.Free; LoadPanel := nil; end;
  if PlanetPanel <> nil then begin PlanetPanel.Free; PlanetPanel := nil; end;
  if ScriptDialogNames <> nil then begin ScriptDialogNames.Free; ScriptDialogNames := nil; end;
  inherited Destroy;
end;
{ @end $52487C }

{ @routine $524D50 TfGov_InitializeLayout }
procedure TfGov.InitializeLayout;
var HalfWidth, ChoiceGrowth: Integer; Owner: Byte;
  // @nested $52491C LayoutPortrait
  procedure LayoutPortrait(Name: WideString; Screen: TMessageLoopGI); // @addr $52491C @ida "void __usercall $name(unsigned __int16 *Name@<eax>, TMessageLoopGI *Screen@<edx>, void *ParentFrame@<^0>);" @stackpop 0 @calls "0x524E8C" @note "Nested in TfGov.InitializeLayout; captures half-width and Self."
  var I, PortraitX, PortraitY, TableY, Bottom, DeltaX, DeltaY: Integer; Panel: TObjectGI;
  begin
    Panel := Screen.FindControlByPath(Name);
    if Panel <> nil then
    begin
      Panel.SetSize(Point(GameScreenWidth, GameScreenHeight));
      PortraitY := Cardinal(GameScreenHeight) div 10;
      TableY := PortraitY + (Panel.FindByNameRecursive('Gov_Anim0').ClientSize.Y div 10) * 6;
      Bottom := TableY + (Panel.FindByNameRecursive('Table').ClientSize.Y div 10) * 9;
      DeltaX := Panel.FindByNameRecursive('Gov_Anim0').LocalPosition.X - Panel.FindByNameRecursive('Gov_Anim1').LocalPosition.X;
      DeltaY := Panel.FindByNameRecursive('Gov_Anim0').ClientSize.Y - Panel.FindByNameRecursive('Gov_Anim1').ClientSize.Y;
      if GameScreenHeight > Bottom then
      begin
        PortraitY := PortraitY + GameScreenHeight - Bottom;
        TableY := TableY + GameScreenHeight - Bottom;
      end;
      with Panel.FindByNameRecursive('Table') do
      begin
        SetPosition(Point(HalfWidth + (HalfWidth - ClientSize.X) div 2, TableY));
        SetActive(UseClassicPortrait);
      end;
      if Panel.FindByNameRecursive('Table2') <> nil then
      with Panel.FindByNameRecursive('Table2') do
      begin
        SetPosition(Point(HalfWidth + (HalfWidth - ClientSize.X) div 2, TableY));
        SetActive(False);
      end;
      PortraitX := (HalfWidth div 2) * 3 - Panel.FindByNameRecursive('Gov_Anim0').ClientSize.X div 2;
      for I := 0 to 1 do
      begin
        with Panel.FindByNameRecursive(WideString('Gov_Anim' + IntToStr(I))) do
          if not UseClassicPortrait then SetPosition(Point(LocalPosition.X + ExtraScreenWidth, LocalPosition.Y + ExtraScreenHeight))
          else SetPosition(Point(PortraitX - I * DeltaX, PortraitY + I * DeltaY));
        with Panel.FindByNameRecursive(WideString('GovHD_Anim' + IntToStr(I))) do
          SetPosition(Point(HalfWidth + (HalfWidth - ClientSize.X) div 2, LocalPosition.Y + ExtraScreenHeight));
      end;
      Panel.FindByNameRecursive('BG').SetSize(Point(GameScreenWidth, GameScreenHeight));
    end;
  end;
begin
  inherited InitializeLayout;
  MainPanel.InitializeLayout(Self);
  PlanetPanel.InitializeLayout(Self);
  LoadPanel.InitializeLayout(Self);
  AppendLogTextThreadSafe('fGov... ');
  ViewportRect := Classes.Rect(0, 0, GameScreenWidth, GameScreenHeight);
  with GetByName('MainPanel') do
  begin
    SetSize(Point(GameScreenWidth, GameScreenHeight));
    HalfWidth := Cardinal(GameScreenWidth) div 2;
    UseHdPortrait := False;
    UseClassicPortrait := False;
    if (Cardinal(GameScreenWidth) >= 1280) and (Cardinal(GameScreenHeight) >= 960) then
    begin
      UseHdPortrait := True;
      UseClassicPortrait := UseTablesForGov;
    end;
    for Owner := 0 to 7 do LayoutPortrait('Gov' + OwnerInfo[Owner].InternalName, Self);
    with FindByNameRecursive('PanelTalk') do
    begin
      HalfWidth := Min(Max(ExtraScreenHeight, 0), 250) div 3;
      ChoiceGrowth := (HalfWidth div 4) * 3;
      HalfWidth := HalfWidth * 3 - ChoiceGrowth;
      if ExtraScreenHeight < 0 then SetPosition(Point(LocalPosition.X + ExtraScreenWidth div 2, LocalPosition.Y + ExtraScreenHeight div 2))
      else SetPosition(Point(LocalPosition.X + ExtraScreenWidth div 2, LocalPosition.Y));
      SetSize(Point(ClientSize.X, ClientSize.Y + HalfWidth + ChoiceGrowth));
      with FirstChild do
      begin
        SetPosition(Point(LocalPosition.X, LocalPosition.Y + HalfWidth));
        SetSize(Point(ClientSize.X, ClientSize.Y + ChoiceGrowth));
      end;
      with FindByNameRecursive('UserMsgAdd') do SetPosition(Point(LocalPosition.X, LocalPosition.Y + HalfWidth));
      with FindByNameRecursive('ButFormClose') do SetPosition(Point(LocalPosition.X, LocalPosition.Y + HalfWidth + ChoiceGrowth));
      with FindByNameRecursive('TextScroll') as TPanelScrollBarGI do
      begin
        SetSize(Point(ClientSize.X, ClientSize.Y + HalfWidth));
        VerticalScrollBar.SetSize(Point(VerticalScrollBar.ClientSize.X, VerticalScrollBar.ClientSize.Y + HalfWidth));
        with FindByNameRecursive('TalkText') do SetSize(Point(ClientSize.X, ClientSize.Y + HalfWidth));
      end;
      with FindByNameRecursive('TalkPA') as TPanelScrollBarGI do
      begin
        SetPosition(Point(LocalPosition.X, LocalPosition.Y + HalfWidth));
        SetSize(Point(ClientSize.X, ClientSize.Y + ChoiceGrowth));
        TObjectGI(VerticalScrollBar).SetPosition(Point(VerticalScrollBar.LocalPosition.X, VerticalScrollBar.LocalPosition.Y + HalfWidth));
        VerticalScrollBar.SetSize(Point(VerticalScrollBar.ClientSize.X, VerticalScrollBar.ClientSize.Y + ChoiceGrowth));
        with NextSibling do
        begin
          SetSize(Point(ClientSize.X, ClientSize.Y + HalfWidth + ChoiceGrowth));
          with NextSibling do
          begin
            SetPosition(Point(LocalPosition.X, LocalPosition.Y + HalfWidth + ChoiceGrowth));
            with NextSibling do
            begin
              SetPosition(Point(LocalPosition.X, LocalPosition.Y + HalfWidth));
              with NextSibling do SetPosition(Point(LocalPosition.X, LocalPosition.Y + HalfWidth));
            end;
          end;
        end;
      end;
    end;
  end;
  AppendLogLineThreadSafe('ok');
  GetByName('MainPanel').KeyDownCallback := MainPanelKeyDown;
  with GetByName('UserMsgAdd') as TGraphButtonGI do UpCallback := AddMessageClicked;
  with GetByName('ButFormClose') as TGraphButtonGI do UpCallback := PlanetPanel.PlanetClicked;
end;
{ @end $524D50 }

// Reviewed compiler-layout difference: native reserves one extra, unreferenced
// dword at EBP-$F4, before its managed-string temporaries, and emits an extra
// push ECX in the prologue. Rebuilt temporaries from $F8 onward are four bytes
// nearer EBP. Calls, branches, constants and field accesses agree throughout.
{ @routine $525414 TfGov_OnOpen }
procedure TfGov.OnOpen;
var
  Owner: Byte;
  MapIndex, Money, ExperienceAwarded: Integer;
  Text, WinText, LossText, TerronName: WideString;
  Event: TGalaxyEvent;
  Stage: Integer;
  Failed: Boolean;
  Portrait: TObjectGI;
  // Four native frame bytes precede compiler temporaries; no access identifies their type.
  UnresolvedFrameBytes: array[0..3] of Byte;
begin
  Stage := 0;
  try
    if not MusicInPlanetEnabled then MusicManager.RequestFadeOut;
    MainPanel.OnOpen;
    PlanetPanel.OnOpen;
    LoadPanel.OnOpen;
    SavedChoiceScroll := -1;
    Stage := 1;
    (GetByName('PM_EndTurn') as TGraphButtonGI).UpCallback := EndTurnClicked;
    (GetByName('PM_Ship') as TGraphButtonGI).UpCallback := ShipClicked;
    if GetPlayer.CurrentPlanet.IsMainPiratePlanet then SoundSection := 0
    else SoundSection := GetPlayer.CurrentPlanet.RaceId + 1;
    Stage := 2;
    if GetPlayer.CurrentPlanet <> TemporaryShopPlanet then
    begin
      SelectMusic;
      if TemporaryShopSlots <> nil then RestoreTemporaryShopStock;
      RunGlobalScriptsForContext(GetPlayer.CurrentStar, 0);
      PruneExpiredPersistentPlayerMessages;
      BuildTemporaryShopSlotGrid;
    end;
    Stage := 3;
    if (GetPlayer = nil) or ((GetPlayer.CurrentPlanet <> nil) and (GetPlayer.CurrentStar.ControlFaction = sfDominators)) then
    begin
      Event := AddGalaxyEvent('PlayerDeath');
      Event.AddTextData('PlanetCaptured');
      GameEndReason := 2;
      RequestedScreenId := screenGameEnd;
      RequestClose(1);
      Exit;
    end;
    if GetPlayer.PendingDockDialogue = 1 then GetPlayer.PendingDockDialogue := 0;
    Stage := 4;
    for Owner := 0 to 7 do
    begin
      Portrait := FindControlByPath('Gov' + OwnerInfo[Owner].InternalName);
      if Portrait <> nil then Portrait.SetActive(False);
    end;
    if GetPlayer.CurrentPlanet.IsMainPiratePlanet and (GetPlayer.CurrentPlanet.OwnerId = Byte(oiPirate)) then
      PortraitPanel := GetByName('GovPirateClan')
    else PortraitPanel := GetByName('Gov' + OwnerInfo[RaceToOwner(GetPlayer.CurrentPlanet.RaceId)].InternalName);
    PortraitPanel.SetActive(True);
    with PortraitPanel do
    begin
      if FindByNameRecursive('Table2') <> nil then
      begin
        FindByNameRecursive('Table').SetActive((GetPlayer.CurrentPlanet.OwnerId <> Byte(oiPirate)) and UseHdPortrait and UseClassicPortrait);
        FindByNameRecursive('Table2').SetActive((GetPlayer.CurrentPlanet.OwnerId = Byte(oiPirate)) and UseHdPortrait and UseClassicPortrait);
      end
      else FindByNameRecursive('Table').SetActive(UseHdPortrait and UseClassicPortrait);
      with FindByNameRecursive('BG') as TImageGI do
        if GetPlayer.CurrentPlanet.IsMainPiratePlanet then SetImagePath('GI,Bm.Gov.PirateBG')
        else if GetPlayer.CurrentPlanet.OwnerId = Byte(oiPirate) then
          SetImagePath('GI,Bm.Gov.' + OwnerInfo[RaceToOwner(GetPlayer.CurrentPlanet.RaceId)].InternalName + 'PirateBG')
        else SetImagePath('GI,Bm.Gov.2' + OwnerInfo[RaceToOwner(GetPlayer.CurrentPlanet.RaceId)].InternalName + 'BGi');
      if UseHdPortrait and not UseClassicPortrait then
      begin
        with FindByNameRecursive('GovHD_Anim0') as TgaiGI do
        begin
          FirstFrameOnly := AnimGov = 0;
          PrimeImageCaches;
        end;
        if AnimGov = 2 then
        with FindByNameRecursive('GovHD_Anim1') as TgaiGI do
        begin
          FirstFrameOnly := AnimGov = 0;
          PrimeImageCaches;
        end;
      end
      else
      begin
        with FindByNameRecursive('Gov_Anim0') as TgaiGI do
        begin
          FirstFrameOnly := AnimGov = 0;
          PrimeImageCaches;
        end;
        if AnimGov = 2 then
        with FindByNameRecursive('Gov_Anim1') as TgaiGI do
        begin
          FirstFrameOnly := AnimGov = 0;
          PrimeImageCaches;
        end;
      end;
    end;
    Stage := 5;
    Stage := 6;
    with GetByName('TalkText') as TLabelGI do
    begin
      SetText('');
      if FontDialog = 0 then SetFontName(NormalFontName)
      else if FontDialog = 1 then SetFontName(SmoothBigFontName)
      else if FontDialog = 2 then SetFontName(SmoothHugeFontName)
      else if FontDialog >= 3 then SetFontName(SmoothIntroFontName);
    end;
    UpdatePortraitAnimation(True);
    Stage := 7;
    if PendingTransition = 1 then
    begin
      Stage := 8;
      MapIndex := FindRobotMapById(PlanetBattleMapId);
      Text := RobotMapDefinitions[MapIndex].RobotsStart;
      ReplaceTextToken(Text, '<Star>', GetPlayer.CurrentStar.Name, '<color=255,240,100>');
      ReplaceTextToken(Text, '<Planet>', GetPlayer.CurrentPlanet.Name, '<color=255,240,100>');
      ReplaceTextToken(Text, '<Player>', GetPlayer.Name, '<color=255,240,100>');
      ExpandLocalizedTextMarkupAndPrefixLines(Text);
      Text := WideString(IntToStr(GovernmentBattleDifficulty)) + Text;
      Text := WideString(IntToStr(Min(Galaxy.GetDifficultyTierIndex, 3) + 1)) + Text;
      Text := WideString(IntToStr(GetPlayer.CurrentPlanet.RaceId + 1)) + Text;
      WinText := RobotMapDefinitions[MapIndex].RobotsWin;
      ReplaceTextToken(WinText, '<Star>', GetPlayer.CurrentStar.Name, '<color=255,240,100>');
      ReplaceTextToken(WinText, '<Planet>', GetPlayer.CurrentPlanet.Name, '<color=255,240,100>');
      ReplaceTextToken(WinText, '<Player>', GetPlayer.Name, '<color=255,240,100>');
      ExpandLocalizedTextMarkupAndPrefixLines(WinText);
      LossText := RobotMapDefinitions[MapIndex].RobotsLoss;
      ReplaceTextToken(LossText, '<Star>', GetPlayer.CurrentStar.Name, '<color=255,240,100>');
      ReplaceTextToken(LossText, '<Planet>', GetPlayer.CurrentPlanet.Name, '<color=255,240,100>');
      ReplaceTextToken(LossText, '<Player>', GetPlayer.Name, '<color=255,240,100>');
      ExpandLocalizedTextMarkupAndPrefixLines(LossText);
      TerronName := GetPlayer.CurrentPlanet.GetFullName(' ') + ', ' + LookupLocalizedTextOrEmpty('FormShip.StorageInfo.StarInfo') + ' ' + GetPlayer.CurrentStar.Name;
      Stage := 9;
      if IsTurnCalculationRunning and (WaitForSingleObject(ScriptUiRequestEvent, 0) <> WAIT_OBJECT_0) then WaitForTurnCalculation;
      if not MemorySnapshotActive then SaveGameToMemorySnapshot;
      LoadPanel.OnOpen;
      LoadPanel.SelectBackgroundStyle(3);
      LoadPanel.RefreshBackgroundImages;
      Stage := 10;
      try
        Failed := False;
        PendingTransition := FRun(RobotMapDefinitions[MapIndex].Map, Text, WinText, LossText, TerronName);
      except
        on E: Exception do
        begin
          AppendLogLineThreadSafe(E.ClassName + ' ' + E.Message);
          Failed := True;
        end;
      end;
      Stage := 11;
      if MemorySnapshotActive then RestoreGameFromMemorySnapshot;
      Stage := 12;
      if Failed then
      begin
        if ShowMessageBoxGI(Self, LocalizedColorText('FormGov.BattlePlanetQuestCrashed'), mbgOK or mbgCancel or mbgQuestion) = mbgResultOK then
          PendingTransition := 3
        else raise Exception.Create('Error in Matrix.dll');
      end;
      if PendingTransition = 0 then Exit;
      if PendingTransition = 1 then
      begin
        PendingTransition := 0;
        if MemorySnapshotBuffer <> nil then MemorySnapshotBuffer.Free;
        MemorySnapshotBuffer := nil;
        MemorySnapshotActive := False;
        if (Galaxy <> nil) and not Galaxy.Destroying then Galaxy.Free;
        Galaxy := nil;
        ScreenLoadMode := 4;
        PostLoadScreenId := screenMainMenu;
        RequestedScreenId := screenLoad;
        RequestClose(1);
        Exit;
      end;
      RequestedScreenId := screenGovernment;
      RequestClose(1);
      Exit;
    end;
    if PendingTransition = 2 then
    begin
      Stage := 13;
      MapIndex := FindRobotMapById(PlanetBattleMapId);
      Money := RoundAndTruncateToTens(Min(GetPlayer.Wealth * 0.03, Min(Galaxy.ComputeScaledAverageMoney(2) * 7, Galaxy.ComputeScaledHugeMoney(2) * 1.5)));
      Money := Round(Money * GalaxyDifficultyTuning[Galaxy.DifficultyLevels[5]].ArcadeRewardScale);
      case GovernmentBattleDifficulty of
        1: Money := RoundAndTruncateToTens(Money * 0.5);
        2: Money := RoundAndTruncateToTens(Money * 0.2);
        3: Money := RoundAndTruncateToTens(Money * 0.1);
      end;
      Stage := 14;
      GetPlayer.SetMoney(GetPlayer.Money + Money);
      SoundManager.PlaySound('Sound.Sell');
      GetPlayer.CurrentPlanet.ChangeRelationToRanger(GetPlayer, -40);
      DialogText := RobotMapDefinitions[MapIndex].GovTextLoss;
      ReplaceTextToken(DialogText, '<Star>', GetPlayer.CurrentStar.Name, '<color=255,240,100>');
      ReplaceTextToken(DialogText, '<Planet>', GetPlayer.CurrentPlanet.Name, '<color=255,240,100>');
      ReplaceTextToken(DialogText, '<Player>', GetPlayer.Name, '<color=255,240,100>');
      ReplaceTextToken(DialogText, '<Money>', WideString(IntToStr(Money)), '<color=255,240,100>');
      Stage := 15;
      BuildGovernmentChoices(True);
      Stage := 16;
      SetLength(GetPlayer.PlanetBattleHistory, High(GetPlayer.PlanetBattleHistory) + 1 + 1);
      with GetPlayer.PlanetBattleHistory[High(GetPlayer.PlanetBattleHistory)] do
      begin
        MapId := PlanetBattleMapId;
        Statistics[0] := RobotBattleStatistics[0];
        Statistics[1] := RobotBattleStatistics[1];
        Statistics[2] := RobotBattleStatistics[2];
        Statistics[3] := RobotBattleStatistics[3];
        Statistics[4] := RobotBattleStatistics[4];
        Statistics[5] := RobotBattleStatistics[5];
        ResultCode := GovernmentBattleDifficulty;
        CompletionMode := PendingTransition;
        DateTurn := Galaxy.CurrentTurn;
      end;
      GetPlayer.LastPlanetBattleTurn := Galaxy.CurrentTurn;
    end
    else if PendingTransition = 3 then
    begin
      Stage := 17;
      MapIndex := FindRobotMapById(PlanetBattleMapId);
      Money := RoundAndTruncateToTens(Max(GetPlayer.Wealth * 0.03, Galaxy.ComputeScaledBigMoney(2)));
      Money := Round(Money * GalaxyDifficultyTuning[Galaxy.DifficultyLevels[5]].QuestMoneyFactor);
      if GetPlayer.IsHealthEffectActive(23) then
        Money := Round(SeededRandomFloatRange((Integer(GetPlayer.CurrentPlanet.GenerationSeed) + Galaxy.CurrentTurn) div 33, 1.3, 2.3) * Money);
      Inc(Money, Round(Money * GetPlayer.GetEffectiveSkillLevel(psCharisma) * 0.1));
      case GovernmentBattleDifficulty of
        1: Money := RoundAndTruncateToTens(Money * 4.0);
        2: Money := RoundAndTruncateToTens(Money * 1.6);
        3: Money := RoundAndTruncateToTens(Money * 0.8);
      end;
      Stage := 18;
      GetPlayer.SetMoney(GetPlayer.Money + Money);
      SoundManager.PlaySound('Sound.LiberationSystem');
      Stage := 19;
      DialogText := RobotMapDefinitions[MapIndex].GovTextWin;
      ReplaceTextToken(DialogText, '<Star>', GetPlayer.CurrentStar.Name, '<color=255,240,100>');
      ReplaceTextToken(DialogText, '<Planet>', GetPlayer.CurrentPlanet.Name, '<color=255,240,100>');
      ReplaceTextToken(DialogText, '<Player>', GetPlayer.Name, '<color=255,240,100>');
      ReplaceTextToken(DialogText, '<Money>', WideString(IntToStr(Money)), '<color=255,240,100>');
      DialogText := DialogText + GetPlayer.GrantPlanetQuestReward(GovernmentBattleDifficulty, ExperienceAwarded);
      Event := AddGalaxyEvent('PlayerFinishesPlanetaryBattle');
      Event.AddData(PlanetBattleMapId);
      Event.AddData(Money);
      Event.AddData(ExperienceAwarded);
      Stage := 20;
      BuildGovernmentChoices(True);
      Stage := 21;
      SetLength(GetPlayer.PlanetBattleHistory, High(GetPlayer.PlanetBattleHistory) + 1 + 1);
      with GetPlayer.PlanetBattleHistory[High(GetPlayer.PlanetBattleHistory)] do
      begin
        MapId := PlanetBattleMapId;
        Statistics[0] := RobotBattleStatistics[0];
        Statistics[1] := RobotBattleStatistics[1];
        Statistics[2] := RobotBattleStatistics[2];
        Statistics[3] := RobotBattleStatistics[3];
        Statistics[4] := RobotBattleStatistics[4];
        Statistics[5] := RobotBattleStatistics[5];
        ResultCode := GovernmentBattleDifficulty;
        CompletionMode := PendingTransition;
        DateTurn := Galaxy.CurrentTurn;
      end;
      Stage := 22;
      GetPlayer.LastPlanetBattleTurn := Galaxy.CurrentTurn;
      Inc(GetPlayer.PlanetBattles);
      TryAddAchievementProgress('IRONMAN', 1);
      Stage := 23;
      LoadRobotScreen.LoadCompletionData;
      if GovernmentBattleDifficulty = 1 then LoadRobotScreen.RecordCompletion(PlanetBattleMapId, -RobotBattleStatistics[0] div 1000, 2)
      else LoadRobotScreen.RecordCompletion(PlanetBattleMapId, -RobotBattleStatistics[0] div 1000, 1);
      LoadRobotScreen.SaveCompletionData;
    end
    else if PendingTransition = 4 then
    begin
      Stage := 24;
      GetPlayer.CurrentPlanet.SetRelationLevelToRanger(GetPlayer, rlBad);
      DialogText := PickLocalizedTextVariant('FormGov.PlanetBattle.GovAfterCancel', (Galaxy.CurrentTurn div 10) * GetPlayer.CurrentPlanet.GenerationSeed + 124);
      ClearDialogChoices;
      AddChoice(PickLocalizedTextVariant('FormGov.PlanetBattle.PlayerAfterCancelNormal', (Galaxy.CurrentTurn div 10) * GetPlayer.CurrentPlanet.GenerationSeed + 123), 0, DeclineBattleAndLeave);
      AddChoice(PickLocalizedTextVariant('FormGov.PlanetBattle.PlayerAfterCancelPrison', (Galaxy.CurrentTurn div 10) * GetPlayer.CurrentPlanet.GenerationSeed + 123), 0, ChoosePrisonInsteadOfBattle);
      Stage := 25;
      SetLength(GetPlayer.PlanetBattleHistory, High(GetPlayer.PlanetBattleHistory) + 1 + 1);
      with GetPlayer.PlanetBattleHistory[High(GetPlayer.PlanetBattleHistory)] do
      begin
        MapId := PlanetBattleMapId;
        Statistics[0] := RobotBattleStatistics[0];
        Statistics[1] := RobotBattleStatistics[1];
        Statistics[2] := RobotBattleStatistics[2];
        Statistics[3] := RobotBattleStatistics[3];
        Statistics[4] := RobotBattleStatistics[4];
        Statistics[5] := RobotBattleStatistics[5];
        ResultCode := GovernmentBattleDifficulty;
        CompletionMode := PendingTransition;
        DateTurn := Galaxy.CurrentTurn;
      end;
      GetPlayer.LastPlanetBattleTurn := Galaxy.CurrentTurn;
    end;
    Stage := 26;
    if PendingTransition = 0 then RefreshGovernmentDialog;
    PendingTransition := 0;
    Stage := 27;
    RestartTextPresentation(False);
    Stage := 28;
    with GetByName('TalkPA') as TPanelScrollBarGI do SetVerticalScrollbarEnabled(False);
    AnimationRestartRequested := False;
    MainPanel.RebuildMessageButtons(False);
    Stage := 29;
    if GetPlayer <> nil then GetPlayer.ScriptItemsAct($18, nil, nil, 0);
    Galaxy.PrimeIntegrityChecksum(170);
  except
    on E: Exception do
    begin
      AppendLogLineThreadSafe(E.ClassName + ' ' + E.Message);
      raise Exception.Create('Error in procedure TfGov.BeforeRun, label = ' + IntToStr(Stage));
    end;
  end;
end;
{ @end $525414 }

{ @routine $527230 TfGov_OnClose }
procedure TfGov.OnClose;
begin
  if Galaxy <> nil then Galaxy.CheckIntegrityChecksum(171);
  if GetPlayer <> nil then GetPlayer.ScriptItemsAct($19, nil, nil, 0);
  LoadPanel.OnClose;
  ScriptDialogIndex := -1;
  ClearDialogChoices;
  MainPanel.OnClose;
  PlanetPanel.OnClose;
  ScriptDialogNames.Clear;
end;
{ @end $527230 }

{ @routine $5272BC TfGov_EndTurnClicked }
procedure TfGov.EndTurnClicked(Sender: TObjectGI);
begin
  if (GetPlayer.CurrentPlanet.GetRelationLevelToShip(GetPlayer) > rlHostile) and (GetPlayer.PendingDockDialogue <= 1) then
  begin
    Galaxy.CheckIntegrityChecksum(172);
    RestoreTemporaryShopStock;
    MainPanel.EndTurnClicked(Sender);
    MainPanel.RebuildMessageButtons(False);
    if ExitCode = 0 then
    begin
      BuildTemporaryShopSlotGrid;
      UpdatePortraitAnimation(True);
      RefreshGovernmentDialog;
      Galaxy.PrimeIntegrityChecksum(173);
      RestartTextPresentation(True);
      AnimationRestartRequested := False;
    end;
  end;
end;
{ @end $5272BC }

{ @routine $527374 TfGov_ShipClicked }
procedure TfGov.ShipClicked(Sender: TObjectGI);
begin
  MainPanel.ShipClicked(Sender);
  if ShipScreen.Flag3BC then
  begin
    Galaxy.CheckIntegrityChecksum(302);
    RefreshGovernmentDialog;
    Galaxy.PrimeIntegrityChecksum(303);
    RestartTextPresentation(True);
    MainPanel.RebuildMessageButtons(False);
  end;
end;
{ @end $527374 }

{ @routine $5273EC TfGov_RequestAnimationRestart }
procedure TfGov.RequestAnimationRestart;
begin
  AnimationRestartRequested := True;
end;
{ @end $5273EC }

{ @routine $527400 TfGov_PortraitAnimationComplete }
procedure TfGov.PortraitAnimationComplete(Sender: TObjectGI);
begin
  if AnimationRestartRequested then
  begin
    UpdatePortraitAnimation(True);
    AnimationRestartRequested := False;
  end
  else UpdatePortraitAnimation(False);
end;
{ @end $527400 }

{ @routine $52743C TfGov_UpdatePortraitAnimation }
procedure TfGov.UpdatePortraitAnimation(Talking: Boolean);
begin
  if AnimGov <> 2 then Talking := False;
  if UseHdPortrait and not UseClassicPortrait then
  begin
    with PortraitPanel.FindByNameRecursive('GovHD_Anim0') as TgaiGI do
    begin
      CycleCompleteCallback := PortraitAnimationComplete;
      SetSequenceFrame(0);
      StopAutoPlayback;
      if not Talking then RestartPlayback
      else StopAutoPlayback;
      SetActive(not Talking);
    end;
    with PortraitPanel.FindByNameRecursive('GovHD_Anim1') as TgaiGI do
    begin
      CycleCompleteCallback := PortraitAnimationComplete;
      SetSequenceFrame(0);
      StopAutoPlayback;
      if Talking then RestartPlayback
      else StopAutoPlayback;
      SetActive(Talking);
    end;
  end
  else
  begin
    with PortraitPanel.FindByNameRecursive('Gov_Anim0') as TgaiGI do
    begin
      CycleCompleteCallback := PortraitAnimationComplete;
      SetSequenceFrame(0);
      StopAutoPlayback;
      if not Talking then RestartPlayback
      else StopAutoPlayback;
      SetActive(not Talking);
    end;
    with PortraitPanel.FindByNameRecursive('Gov_Anim1') as TgaiGI do
    begin
      CycleCompleteCallback := PortraitAnimationComplete;
      SetSequenceFrame(0);
      StopAutoPlayback;
      if Talking then RestartPlayback
      else StopAutoPlayback;
      SetActive(Talking);
    end;
  end;
end;
{ @end $52743C }

{ @routine $5276A0 TfGov_RememberChoiceScroll }
procedure TfGov.RememberChoiceScroll;
begin
  SavedChoiceScroll := (GetByName('TalkPA') as TPanelScrollBarGI).VerticalScrollBar.Position;
end;
{ @end $5276A0 }

{ @routine $5276EC TfGov_ClearDialogChoices }
procedure TfGov.ClearDialogChoices;
var Child, Panel: TObjectGI;
begin
  NextChoiceTop := 0;
  Panel := GetByName('TalkPA');
  Child := Panel.FirstChild;
  while Child <> nil do
  begin
    TObject(Child.UserValue).Free;
    Child := Child.NextSibling;
  end;
  Panel.FreeOwnedChildren;
  Panel.Invalidate;
end;
{ @end $5276EC }

{ @routine $527768 TfGov_AddChoice }
procedure TfGov.AddChoice(Text: WideString; Value: Integer; Callback: TDialogChoiceEventGI);
var Panel: TPanelScrollBarGI; Choice: TfTalkA; I: Integer; Row: TPanelGI;
  Highlight: TImageGI; BlockMode: Byte;
begin
  BlockMode := 0;
  if ScriptDialogBlocks <> nil then
    for I := 0 to ScriptDialogBlocks.Count - 1 do
      if FindTextOffsetW(Text, PScriptDialogBlock(ScriptDialogBlocks[I]).Text) >= 0 then
        BlockMode := Max(BlockMode, PScriptDialogBlock(ScriptDialogBlocks[I]).Mode);
  if BlockMode >= 2 then Exit;
  Panel := GetByName('TalkPA') as TPanelScrollBarGI;
  I := 0;
  while I < Length(Text) do
  begin
    if (Text[I + 1] <> '-') and (Text[I + 1] <> ' ') then Break;
    Inc(I);
  end;
  if I > 0 then Text := Copy(Text, I + 1, Length(Text) - I);
  Choice := TfTalkA.Create;
  Choice.Callback := Callback;
  Choice.Value := Value;
  if BlockMode > 0 then Choice.Callback := nil;
  Row := TPanelGI.Create(Panel);
  Row.UserValue := Integer(Choice);
  Row.SetPosition(Point(0, NextChoiceTop));
  Row.SetSize(Point(Panel.ClientSize.X, 20));
  Row.SetPositionModeW(True);
  Row.MouseEnterCallback := ChoiceMouseEnter;
  Row.MouseLeaveCallback := ChoiceMouseLeave;
  Row.LeftButtonDownCallback := ChoiceMouseDown;
  Row.LeftButtonUpCallback := ChoiceMouseUp;
  Highlight := TImageGI.Create(Row);
  Highlight.SetDepth(3);
  Highlight.SetPosition(Point(0, 0));
  Highlight.SetSize(Point(Panel.ClientSize.X, 20));
  Highlight.SetImagePath('GI,Bm.FormGov2.' + GiResourceSuffix + 'Line');
  Highlight.SetImageKindX(ikxLeftFill);
  Highlight.SetImageKindY(ikyTopFill);
  Highlight.SetActive(False);
  with TLabelGI.Create(Row) do
  begin
  if FontDialog = 0 then SetFontName(NormalFontName)
  else if FontDialog = 1 then SetFontName(SmoothBigFontName)
  else if FontDialog = 2 then SetFontName(SmoothHugeFontName)
  else if FontDialog >= 3 then SetFontName(SmoothIntroFontName);
  SetSize(Point(Panel.ClientSize.X - GiScalePixels(20), 20));
  SetPosition(Point(GiScalePixels(10), 0));
  SetWordWrapEnabled(True);
  SetTextAlignX(taxLeft);
  SetTextAlignY(tayAuto);
  if not Assigned(Callback) then Text := RemoveTextTagsW(Text);
  SetText('<Object=0,20,14,0>' + ReplaceAllWideString(Text, '<color=255,240,100>', '<color=0,50,200>'));
  SetTextColor(CurrentPixelFormat.PackRgbBytes(0, 0, 0));
  if not Assigned(Choice.Callback) then SetTextColor(CurrentPixelFormat.PackRgbBytes(127, 127, 127));
  CreateEmbeddedControl := CreateDialogObject;
  SetTextAlignY(tayCenterEx);
  Row.SetSize(Point(Row.ClientSize.X, ClientSize.Y + 2 * GiScalePixelsEx(2, 2)));
  SetSize(Point(ClientSize.X, Row.ClientSize.Y));
  Highlight.SetSize(Row.ClientSize);
  Inc(NextChoiceTop, ClientSize.Y);
  end;
end;
{ @end $527768 }

{ @routine $527D34 TfGov_ChoiceMouseEnter }
procedure TfGov.ChoiceMouseEnter(Sender: TObjectGI);
begin
  Sender.FirstChild.SetActive(True);
end;
{ @end $527D34 }

{ @routine $527D54 TfGov_ChoiceMouseLeave }
procedure TfGov.ChoiceMouseLeave(Sender: TObjectGI);
begin
  Sender.FirstChild.SetActive(False);
end;
{ @end $527D54 }

{ @routine $527D74 TfGov_ChoiceMouseDown }
procedure TfGov.ChoiceMouseDown(Sender: TObjectGI; KeyState: Cardinal; Point: TPoint);
begin
  if (Sender.FirstChild <> nil) and (Sender.FirstChild.NextSibling <> nil) and
    (Sender.FirstChild.NextSibling.FirstChild <> nil) and (Sender.FirstChild.NextSibling.FirstChild.FirstChild <> nil) then
    Sender.FirstChild.NextSibling.FirstChild.FirstChild.SetPosition(Classes.Point(2, 0));
end;
{ @end $527D74 }

{ @routine $527DF4 TfGov_ChoiceMouseUp }
procedure TfGov.ChoiceMouseUp(Sender: TObjectGI; KeyState: Cardinal; Point: TPoint);
var Choice: TfTalkA;
begin
  if (Sender.FirstChild <> nil) and (Sender.FirstChild.NextSibling <> nil) and
    (Sender.FirstChild.NextSibling.FirstChild <> nil) and (Sender.FirstChild.NextSibling.FirstChild.FirstChild <> nil) then
    Sender.FirstChild.NextSibling.FirstChild.FirstChild.SetPosition(Classes.Point(0, 0));
  Galaxy.CheckIntegrityChecksum(174);
  Choice := TfTalkA(Sender.UserValue);
  if Assigned(Choice.Callback) then Choice.Callback(Choice.Value)
  else if Assigned(Choice.FallbackCallback) then Choice.FallbackCallback(Choice.FallbackText)
  else
  begin
    Galaxy.PrimeIntegrityChecksum(176);
    Exit;
  end;
  Galaxy.PrimeIntegrityChecksum(175);
  RestartTextPresentation(True);
  MainPanel.RefreshMoneyAndCargo;
  MainPanel.RebuildMessageButtons(False);
  BreakUiMessage;
end;
{ @end $527DF4 }

{ @routine $527F14 TfGov_RestartTextPresentation }
procedure TfGov.RestartTextPresentation(RestartAnimation: Boolean);
begin
  if RestartAnimation then RequestAnimationRestart;
  (GetByName('TalkPA') as TPanelScrollBarGI).SetActive(False);
  FormattedTextLength := 0;
  if DialogRefreshTimer <> nil then
  begin
    CancelCallbackTimer(DialogRefreshTimer);
    DialogRefreshTimer := nil;
  end;
  DialogRefreshTimer := ScheduleCallbackTimer(10, 10, AdvanceTextPresentation);
end;
{ @end $527F14 }

{ @routine $527FC0 TfGov_AdvanceTextPresentation }
procedure TfGov.AdvanceTextPresentation(Timer: PCallbackTimerGI; UserData: Integer);
var Choices, TextPanel: TPanelScrollBarGI;
begin
  if FormattedTextLength >= Length(DialogText) then
  begin
    Choices := GetByName('TalkPA') as TPanelScrollBarGI;
    Choices.SetActive(True);
    Choices.VerticalScrollBar.SetSmallChange((GetByName('TalkText') as TLabelGI).GetLineHeight);
    Choices.VerticalScrollBar.SetLargeChange(Choices.ClientSize.Y);
    Choices.VerticalScrollBar.SetPageSize(Choices.ClientSize.Y);
    Choices.SetScrollOffset(Point(0, 0));
    Choices.VerticalScrollBar.SetActive(NextChoiceTop > Choices.ClientSize.Y);
    Choices.VerticalScrollBar.SetDepth(4);
    Choices.SetDragScrollingEnabled(Choices.VerticalScrollBar.Active);
    Choices.UpdateScrollRanges;
    if DialogRefreshTimer <> nil then
    begin
      CancelCallbackTimer(DialogRefreshTimer);
      DialogRefreshTimer := nil;
    end;
    if SavedChoiceScroll >= 0 then Choices.VerticalScrollBar.SetPosition(SavedChoiceScroll);
    SavedChoiceScroll := -1;
    PostMouseMoveMessage;
  end
  else
  begin
    DialogText := LocalizedTextLinePrefix + TrimWideString(DialogText);
    DialogText := ReplaceAllWideString(DialogText, #13#10 + LocalizedTextLinePrefix, #13#10);
    DialogText := ReplaceAllWideString(DialogText, #13#10, #13#10 + LocalizedTextLinePrefix);
    FormattedTextLength := Length(DialogText);
    DialogText := ReplaceAllWideString(DialogText, '<color=255,240,100>', '<color=0,50,200>');
    (GetByName('TalkText') as TLabelGI).SetText(DialogText);
    TextPanel := GetByName('TextScroll') as TPanelScrollBarGI;
    TextPanel.SetScrollOffset(Point(0, 0));
    TextPanel.UpdateScrollRanges;
    TextPanel.VerticalScrollBar.SetActive((TextPanel.FindByNameRecursive('TalkText') as TLabelGI).ClientSize.Y > TextPanel.ClientSize.Y);
    TextPanel.VerticalScrollBar.SetSmallChange((TextPanel.FindByNameRecursive('TalkText') as TLabelGI).GetLineHeight);
    TextPanel.VerticalScrollBar.SetLargeChange(TextPanel.ClientSize.Y);
    TextPanel.VerticalScrollBar.SetPageSize(TextPanel.ClientSize.Y);
    (GetByName('UserMsgAdd') as TGraphButtonGI).SetDisabled(False);
  end;
end;
{ @end $527FC0 }

{ @routine $528434 TfGov_ProcessMouseWheel }
procedure TfGov.ProcessMouseWheel(KeyState: Cardinal; Point: TPoint; Delta: Integer);
var
  Panel: TPanelScrollBarGI;
begin
  Panel := GetByName('TalkPA') as TPanelScrollBarGI;
  if not Panel.ContainsPoint(Point) then Panel := GetByName('TextScroll') as TPanelScrollBarGI;
  if Delta = WHEEL_DELTA then Panel.VerticalScrollBar.SetPosition(Panel.VerticalScrollBar.Position - Panel.VerticalScrollBar.SmallChange)
  else if Delta = -WHEEL_DELTA then Panel.VerticalScrollBar.SetPosition(Panel.VerticalScrollBar.Position + Panel.VerticalScrollBar.SmallChange);
end;
{ @end $528434 }

{ @routine $52852C TfGov_CreateDialogObject }
function TfGov.CreateDialogObject(LabelControl: TLabelGI; Item: PFontObjectEC): TObjectGI;
var Image: TImageGI;
begin
  Result := TImageGI.Create(LabelControl);
  Image := Result as TImageGI;
  Image.SetImagePath('GI,Bm.FormGov2.' + GiResourceSuffix + 'Answer');
  Image.SetImageKindX(ikxLeft);
end;
{ @end $52852C }

{ @routine $528610 TfGov_MainPanelKeyDown }
procedure TfGov.MainPanelKeyDown(Sender: TObjectGI; Key: Cardinal);
var Panel: TPanelScrollBarGI; Button: TGraphButtonGI;
begin
  if IsVirtualKeyDown(VK_CONTROL) or IsVirtualKeyDown(VK_SHIFT) or IsVirtualKeyDown(VK_MENU) or (ExitCode <> 0) then Exit;
  Panel := GetByName('TextScroll') as TPanelScrollBarGI;
  if Key = VK_SPACE then
  begin
    if GetByName('PM_EndTurn').Active then EndTurnClicked(nil);
  end
  else if Key = Ord('S') then ShipClicked(nil)
  else if Key = VK_UP then Panel.VerticalScrollBar.SetPosition(Panel.VerticalScrollBar.Position - Panel.VerticalScrollBar.SmallChange)
  else if Key = VK_DOWN then Panel.VerticalScrollBar.SetPosition(Panel.VerticalScrollBar.Position + Panel.VerticalScrollBar.SmallChange)
  else if Key = VK_PRIOR then Panel.VerticalScrollBar.SetPosition(Panel.VerticalScrollBar.Position - Panel.VerticalScrollBar.LargeChange)
  else if Key = VK_NEXT then Panel.VerticalScrollBar.SetPosition(Panel.VerticalScrollBar.Position + Panel.VerticalScrollBar.LargeChange)
  else if Key = VK_INSERT then
  begin
    Button := GetByName('UserMsgAdd') as TGraphButtonGI;
    AddMessageClicked(Button);
  end
  else
  begin
    MainPanel.ProcessKeyDown(Key);
    PlanetPanel.ProcessKeyDown(Key);
  end;
end;
{ @end $528610 }

{ @routine $528840 TfGov_AddMessageClicked }
procedure TfGov.AddMessageClicked(Sender: TObjectGI);
var Text: WideString;
begin
  Text := (GetByName('TalkText') as TLabelGI).GetText;
  Text := ReplaceAllWideString(Text, '<color=0,50,200>', '<color=255,240,100>');
  (Sender as TGraphButtonGI).SetDisabled(True);
  SoundManager.PlaySound('Sound.UserMsgAdd');
  AddOrUpdatePlayerBubble(7, Galaxy.CurrentTurn, Text, '');
  MainPanel.RebuildMessageButtons(False);
  BreakUiMessage;
end;
{ @end $528840 }

{ @routine $5289B0 TfGov_SelectMusic }
procedure TfGov.SelectMusic;
begin
  if (ActiveLoadPanel <> nil) and (ActiveLoadPanel.GetShutterDirection = -1) then Exit;
  if not MusicInPlanetEnabled then MusicManager.RequestFadeOut
  else if GetPlayer.CurrentPlanet.OwnerId = Byte(oiPirate) then
  begin
    if not GetPlayer.CurrentPlanet.IsMainPiratePlanet then
      MusicManager.PlayCategory('Nation.' + OwnerInfo[RaceToOwner(GetPlayer.CurrentPlanet.RaceId)].InternalName + 'Pirate')
    else MusicManager.PlayCategory('Nation.PiratePlanetMain');
  end
  else MusicManager.PlayCategory('Nation.' + OwnerInfo[GetPlayer.CurrentPlanet.OwnerId].InternalName);
end;
{ @end $5289B0 }

{ @routine $528B34 TfGov_RefreshGovernmentDialog }
procedure TfGov.RefreshGovernmentDialog;
var I, J: Integer; Planet: TPlanet; Ship: TShip;
begin
  if IsTurnCalculationRunningUI then WaitForTurnCalculationUI;
  if ExitCode = 0 then
  begin
    if GetPlayer.InPrison then
    begin
      if GetPlayer.CurrentPlanet.OwnerId <> Byte(oiPirate) then
        DialogText := LocalizedColorText('FormGov.Prison.GovAfterPrison')
      else DialogText := LocalizedColorText('FormGov.PirateClanPrison.GovAfterPrison');
      GetPlayer.InPrison := False;
      Inc(GetPlayer.PrisonStaysCompleted);
      TryAddAchievementProgress('PRISON', 1);
      for I := 0 to Galaxy.Planets.Count - 1 do
      begin
        Planet := Galaxy.Planets[I];
        for J := 0 to Planet.Warriors.Count - 1 do
        begin
          Ship := Planet.Warriors[J];
          if GetPlayer = Ship.EnemyShip then Ship.EnemyShip := nil;
          if GetPlayer.EnemyShip = Ship then GetPlayer.EnemyShip := nil;
        end;
      end;
      ClearDialogChoices;
      AddChoice(LocalizedColorText('FormGov.I_Continue'), 0, ContinueAfterPrison);
    end
    else if (GetPlayer.CurrentPlanet.GetRelationLevelToShip(GetPlayer) = rlHostile) and
      not HasPendingScriptRequests and not GetPlayer.CurrentPlanet.IsMainPiratePlanet then
    begin
      if GetPlayer.OwnerId <> Byte(oiPirate) then DialogText := LocalizedColorText('FormGov.Prison.GovBeforePrison')
      else DialogText := LocalizedColorText('FormGov.PirateClanPrison.GovBeforePrison');
      ClearDialogChoices;
      if GetPlayer.CurrentPlanet.OwnerId <> Byte(oiPirate) then
        AddChoice(LocalizedColorText('FormGov.Prison.PlayerGoToPrison'), 0, EnterPrison)
      else AddChoice(LocalizedColorText('FormGov.PirateClanPrison.PlayerGoToPrison'), 0, EnterPrison);
    end
    else if GetPlayer.PendingLiberationCeremonyPlanet = GetPlayer.CurrentPlanet then
    begin
      DialogText := TNormalShip(GetPlayer).CollectLiberationRewards;
      ClearDialogChoices;
      AddChoice(LocalizedColorText('FormGov.PlayerAfterCongratulationsLiberator'), 0, ExitGovernment);
    end
    else
    begin
      DialogText := GetPlayer.CurrentPlanet.BuildGovernmentGreeting;
      BuildGovernmentChoices(False);
    end;
  end;
end;
{ @end $528B34 }

{ @routine $5290DC TfGov_BuildGovernmentChoices }
procedure TfGov.BuildGovernmentChoices(SkipScriptResponseText: Boolean);
var
  Script: TScript;
  Text, Mode: WideString;
  I, J, Selected, Priority, PartCount: Integer;
  Swapped: Pointer;
begin
  ClearScriptDialogRules;
  ClearDialogChoices;
  GetPlayer.CurrentPlanet.CollectScriptDialogChoices(ScriptDialogNames);
  ScriptDialogCursor := 0;
  Script := nil;
  ScriptDialogIndex := -1;
  while ScriptDialogCursor < ScriptDialogNames.GetCount do
  begin
    Script := TScript(ScriptDialogNames.GetDataAt(ScriptDialogCursor));
    Script.CallDialogByVariable(ScriptDialogNames.GetTextAt(ScriptDialogCursor));
    if ScriptDialogIndex >= 0 then Break;
    Inc(ScriptDialogCursor);
  end;
  if GetPlayer.TryTurnInAnyQuest(Text) then DialogText := Text;
  if ScriptDialogIndex < 0 then
  begin
    for I := 0 to Galaxy.Scripts.Count - 1 do
    begin
      Script := Galaxy.Scripts[I];
      Script.RunAuxiliaryCode;
    end;
    if ScriptDialogOverrides.Count > 0 then
    begin
      Selected := 0;
      Priority := PScriptDialogOverride(ScriptDialogOverrides[0]).Priority;
      for I := 0 to ScriptDialogOverrides.Count - 1 do
        if PScriptDialogOverride(ScriptDialogOverrides[I]).Priority > Priority then
        begin
          Selected := I;
          Priority := PScriptDialogOverride(ScriptDialogOverrides[I]).Priority;
        end;
      Script := PScriptDialogOverride(ScriptDialogOverrides[Selected]).Script;
      Script.InitCode.LocalVar.GetVar('GAnswerData').SetDword(PScriptDialogOverride(ScriptDialogOverrides[Selected]).AnswerData);
      Text := PScriptDialogOverride(ScriptDialogOverrides[Selected]).DialogName;
      if Text <> '' then
      begin
        Script.CallDialogByVariable(Text);
        if ScriptDialogIndex < 0 then
          AppendLogLineThreadSafe(AnsiString(Script.ScriptFileName + ' has overriden dialog with ' + Text + ' but it failed to start'));
      end;
      if ScriptDialogIndex < 0 then AddBuiltinGovernmentChoices
      else
      begin
        StartScriptMessage(Integer(Script));
      end;
    end
    else
    begin
      Selected := -1;
      Priority := 0;
      if not SkipScriptResponseText then
      for I := 0 to ScriptDialogInjections.Count - 1 do
        if PScriptDialogInjection(ScriptDialogInjections[I]).ReplaceGreeting then
          if (Selected < 0) or (PScriptDialogInjection(ScriptDialogInjections[I]).Priority > Priority) then
          begin
            Priority := PScriptDialogInjection(ScriptDialogInjections[I]).Priority;
            Selected := I;
          end;
      if Selected >= 0 then
        DialogText := PScriptDialogInjection(ScriptDialogInjections[Selected]).Text;
      for I := 1 to ScriptDialogInjections.Count - 1 do
        for J := ScriptDialogInjections.Count - 1 downto I do
          if PScriptDialogInjection(ScriptDialogInjections[J]).Priority > PScriptDialogInjection(ScriptDialogInjections[J - 1]).Priority then
          begin
            Swapped := ScriptDialogInjections[J];
            ScriptDialogInjections[J] := ScriptDialogInjections[J - 1];
            ScriptDialogInjections[J - 1] := Swapped;
          end;
      for I := 0 to ScriptDialogInjections.Count - 1 do
      begin
        if not PScriptDialogInjection(ScriptDialogInjections[I]).ReplaceGreeting then
        begin
          Text := PScriptDialogInjection(ScriptDialogInjections[I]).Text;
          if (Text <> '') and not SkipScriptResponseText then DialogText := DialogText + #13#10 + Text;
        end;
        Text := PScriptDialogInjection(ScriptDialogInjections[I]).Answer;
        if Text <> '' then
        begin
          Mode := '';
          PartCount := CountDelimitedPartsW(Text, '~');
          if PartCount > 1 then
          begin
            Mode := ExtractDelimitedPartW(Text, 0, '~');
            Text := ExtractDelimitedRangeW(Text, 1, PartCount - 1, '~');
          end;
          if Mode = 'block' then AddChoice(Text, 0, ScriptDialogBlockCallback)
          else if Mode = 'snap' then AddChoice(Text, Integer(ScriptDialogInjections[I]), RunInjectedAnswerKeepingScroll)
          else AddChoice(PScriptDialogInjection(ScriptDialogInjections[I]).Answer, Integer(ScriptDialogInjections[I]), RunInjectedAnswer);
        end;
      end;
      AddBuiltinGovernmentChoices;
    end;
  end
  else if not Script.SkipGreeting then
    AddChoice(LocalizedColorText('FormGov.I_Continue'), Integer(Script), StartScriptMessage)
  else
  begin
    Script.SkipGreeting := False;
    StartScriptMessage(Integer(Script));
  end;
end;
{ @end $5290DC }

{ @routine $5297FC TfGov_AddBuiltinGovernmentChoices }
procedure TfGov.AddBuiltinGovernmentChoices;
begin
  if (GetPlayer.CurrentPlanet.CurrentStar.Constellation.Id <> 20) or
    (not GetPlayer.CurrentPlanet.IsMainPiratePlanet and
    (GetPlayer.CurrentPlanet.OwnerId in TOwnerMask(PlanetOwnerMasks.Coalition))) then
    AddChoice(LocalizedColorText('FormGov.I_QueryQuest'), 0, RequestQuest);
  if (GetPlayer.CurrentPlanet.GetRelationLevelToShip(GetPlayer) <= rlNormal) and
    not GetPlayer.CurrentPlanet.IsMainPiratePlanet then
    AddChoice(PickLocalizedTextVariant('FormGov.Bribe.I_Bribe', (Galaxy.CurrentTurn div 10) * GetPlayer.CurrentPlanet.GenerationSeed + 239516), 0, ShowBribeOffer);
  if GetPlayer.CurrentPlanet.FindUnchartedNeighborConstellation <> nil then
    AddChoice(LocalizedColorText('FormGov.BuyMap.I_BuyMap'), 0, ShowMapOffer);
  if GetPlayer.CurrentPlanet.CountBailablePrisoners > 0 then
    AddChoice(LocalizedColorText('FormGov.GuarantPrison.PlayerAsk'), 0, ShowPrisonBail);
  AddChoice('Стратегическое командование Коалиции', -10100, RunInjectedAnswer);
  AddChoice('Открыть окно управления планетами и флотами', -10200, RunInjectedAnswer);
  AddChoice('Планетарное управление (тест)', -10000, RunInjectedAnswer);
  AddChoice(LocalizedColorText('FormGov.I_Exit'), 0, ReturnToPlanet);
end;
{ @end $5297FC }

{ @routine $529AA8 TfGov_ContinueScriptDialog }
procedure TfGov.ContinueScriptDialog;
var Script: TScript;
begin
  ScriptDialogIndex := -1;
  Inc(ScriptDialogCursor);
  Script := nil;
  while ScriptDialogCursor < ScriptDialogNames.GetCount do
  begin
    Script := ScriptDialogNames.GetDataAt(ScriptDialogCursor);
    Script.CallDialogByVariable(ScriptDialogNames.GetTextAt(ScriptDialogCursor));
    if ScriptDialogIndex >= 0 then Break;
    Inc(ScriptDialogCursor);
  end;
  if ScriptDialogIndex < 0 then BuildGovernmentChoices(True)
  else AddChoice(LocalizedColorText('FormGov.I_Continue'), Integer(Script), StartScriptMessage);
end;
{ @end $529AA8 }

{ @routine $529BDC TfGov_AddScriptTakeoffChoice }
procedure TfGov.AddScriptTakeoffChoice(Caption: WideString);
begin
  AddChoice(Caption, CurrentScript.CurrentAnswer, RunScriptTakeoffAnswer);
end;
{ @end $529BDC }

{ @routine $529C40 TfGov_AddScriptPlanetChoice }
procedure TfGov.AddScriptPlanetChoice(Caption: WideString);
begin
  AddChoice(Caption, CurrentScript.CurrentAnswer, RunScriptPlanetAnswer);
end;
{ @end $529C40 }

{ @routine $529CA4 TfGov_AddScriptGoodsChoice }
procedure TfGov.AddScriptGoodsChoice(Caption: WideString);
begin
  AddChoice(Caption, CurrentScript.CurrentAnswer, RunScriptGoodsAnswer);
end;
{ @end $529CA4 }

{ @routine $529D08 TfGov_AddScriptShopChoice }
procedure TfGov.AddScriptShopChoice(Caption: WideString);
begin
  AddChoice(Caption, CurrentScript.CurrentAnswer, RunScriptShopAnswer);
end;
{ @end $529D08 }

{ @routine $529D6C TfGov_AddScriptHangarChoice }
procedure TfGov.AddScriptHangarChoice(Caption: WideString);
begin
  AddChoice(Caption, CurrentScript.CurrentAnswer, RunScriptHangarAnswer);
end;
{ @end $529D6C }

{ @routine $529DD0 TfGov_AddScriptNewsExitChoice }
procedure TfGov.AddScriptNewsExitChoice(Caption: WideString);
begin
  AddChoice(Caption, CurrentScript.CurrentAnswer, RunScriptNewsExitAnswer);
end;
{ @end $529DD0 }

{ @routine $529E34 TfGov_BuildQuestOfferChoices }
procedure TfGov.BuildQuestOfferChoices;
begin
  ClearDialogChoices;
  AddChoice(LocalizedColorText('FormGov.I_QuestAccept'), 0, AcceptQuest);
  AddChoice(LocalizedColorText('FormGov.I_QuestReject'), 0, RejectQuest);
  AddChoice(LocalizedColorText('FormGov.I_QuestEasy'), 0, MakeQuestEasier);
  AddChoice(LocalizedColorText('FormGov.I_QuestDifficult'), 0, MakeQuestHarder);
  if QuestOffer.QuestType = qtPlanetQuest then
    AddChoice(LocalizedColorText('FormGov.I_PlanetQuestClose'), 0, PermanentlyDeclineQuest);
  AddChoice(LocalizedColorText('FormGov.I_Exit'), 0, ReturnToPlanet);
end;
{ @end $529E34 }

{ @routine $52A084 TfGov_StartScriptMessage }
procedure TfGov.StartScriptMessage(Action: Integer);
begin
  ClearDialogChoices;
  CurrentScript := TScript(Action);
  CurrentScript.CallDialogMessage(ScriptDialogIndex);
end;
{ @end $52A084 }

{ @routine $52A0BC TfGov_RunScriptAnswer }
procedure TfGov.RunScriptAnswer(Answer: Integer);
begin
  ClearDialogChoices;
  ScriptDialogIndex := -1;
  CurrentScript.ExecuteDialogAnswer(Answer);
  if ScriptDialogIndex < 0 then RaiseWideMessage('I_Script');
  CurrentScript.CallDialogMessage(ScriptDialogIndex);
end;
{ @end $52A0BC }

{ @routine $52A130 TfGov_RunScriptAnswerKeepingScroll }
procedure TfGov.RunScriptAnswerKeepingScroll(Answer: Integer);
begin
  RememberChoiceScroll;
  RunScriptAnswer(Answer);
end;
{ @end $52A130 }

{ @routine $52A154 TfGov_RunScriptTakeoffAnswer }
procedure TfGov.RunScriptTakeoffAnswer(Answer: Integer);
begin
  CaptureSavePreview;
  CaptureGalaxyPreview(Self);
  SaveManagerReturnScreenId := FormToId(Self);
  SaveGameToFile(SaveManagerScreen.GetAutoSavePath, 'as');
  CurrentScript.ExecuteDialogAnswer(Answer);
  if not HangarScreen.TryTakeOff then RequestedScreenId := screenHangar;
  RequestClose(1);
end;
{ @end $52A154 }

{ @routine $52A210 TfGov_RunScriptPlanetAnswer }
procedure TfGov.RunScriptPlanetAnswer(Answer: Integer);
begin
  CurrentScript.ExecuteDialogAnswer(Answer);
  RequestedScreenId := screenPlanet;
  RequestClose(1);
end;
{ @end $52A210 }

{ @routine $52A244 TfGov_RunScriptGoodsAnswer }
procedure TfGov.RunScriptGoodsAnswer(Answer: Integer);
begin
  CurrentScript.ExecuteDialogAnswer(Answer);
  RequestedScreenId := screenGoodsShop;
  RequestClose(1);
end;
{ @end $52A244 }

{ @routine $52A278 TfGov_RunScriptShopAnswer }
procedure TfGov.RunScriptShopAnswer(Answer: Integer);
begin
  CurrentScript.ExecuteDialogAnswer(Answer);
  RequestedScreenId := screenEquipmentShop;
  RequestClose(1);
end;
{ @end $52A278 }

{ @routine $52A2AC TfGov_RunScriptHangarAnswer }
procedure TfGov.RunScriptHangarAnswer(Answer: Integer);
begin
  CurrentScript.ExecuteDialogAnswer(Answer);
  RequestedScreenId := screenHangar;
  RequestClose(1);
end;
{ @end $52A2AC }

{ @routine $52A2E0 TfGov_RunScriptNewsExitAnswer }
procedure TfGov.RunScriptNewsExitAnswer(Answer: Integer);
begin
  CurrentScript.ExecuteDialogAnswer(Answer);
  RequestedScreenId := screenInfo;
  RequestClose(1);
end;
{ @end $52A2E0 }

{ @routine $52A314 TfGov_EnterPrison }
procedure TfGov.EnterPrison(Action: Integer);
var I: Integer; Ship: TShip;
begin
  CaptureSavePreview;
  CaptureGalaxyPreview(Self);
  SaveManagerReturnScreenId := FormToId(Self);
  SaveGameToFile(SaveManagerScreen.GetAutoSavePath, 'as');
  GetPlayer.InPrison := True;
  GetPlayer.CurrentSystemKills.Normal := 0;
  GetPlayer.CurrentSystemKills.Pirate := 0;
  if GetPlayer.CurrentPlanet.OwnerId = Byte(oiPirate) then
  begin
    if MainPiratePlanet <> nil then MainPiratePlanet.ChangeRelationToRanger(GetPlayer, 80)
    else GetPlayer.CurrentPlanet.ChangeRelationToRanger(GetPlayer, 80);
  end
  else
  begin
    GetPlayer.CurrentPlanet.ChangeRelationToRanger(GetPlayer, 80);
    GetPlayer.ChangePlanetRelations(nil, rcmRaiseTo, 20, TOwnerMask(PlanetOwnerMasks.Coalition));
    GetPlayer.ChangePlanetRelations(GetPlayer.CurrentStar.Constellation, rcmIncrease, 30, TOwnerMask(PlanetOwnerMasks.Coalition));
  end;
  for I := 0 to GetPlayer.CurrentStar.Ships.Count - 1 do
  begin
    Ship := GetPlayer.CurrentStar.Ships[I];
    if ((Ship.TypeId = stWarrior) or ((Ship.TypeId = stPirate) and (TPirate(Ship).PirateType <> 0))) and
      (GetPlayer = Ship.EnemyShip) then
    begin
      Ship.EnemyShip := nil;
      if GetPlayer = Ship.OrderTarget then Ship.OrderNone(False);
    end;
  end;
  StandaloneQuestMode := False;
  QuestReturnScreenId := FormToId(Self);
  RequestedScreenId := screenPlanetQuest;
  RequestClose(1);
end;
{ @end $52A314 }

{ @routine $52A528 TfGov_ContinueAfterPrison }
procedure TfGov.ContinueAfterPrison(Action: Integer);
begin
  if GetPlayer.CurrentPlanet.OwnerId <> Byte(oiPirate) then
    DialogText := LocalizedColorText('FormGov.Prison.GovAfterPrisonNext')
  else DialogText := LocalizedColorText('FormGov.PirateClanPrison.GovAfterPrisonNext');
  BuildGovernmentChoices(True);
end;
{ @end $52A528 }

{ @routine $52A668 TfGov_ShowBribeOffer }
procedure TfGov.ShowBribeOffer(Action: Integer);
var Cost, RelationDeficit: Integer; Text: WideString;
begin
  if GetPlayer.CurrentPlanet.OwnerId <> Byte(oiPirate) then
  begin
    RelationDeficit := 100 - GetPlayer.CurrentPlanet.RelationToShip(GetPlayer);
    Cost := Round(RemapClamped(RelationDeficit, 0, 100, 1, 5) * (Galaxy.AverageRangerCapital div 100) *
      OwnerInfo[GetPlayer.CurrentPlanet.OwnerId].FuelPriceFactor);
    Text := PickLocalizedTextVariant('FormGov.Bribe.Question', (Galaxy.CurrentTurn div 10) * GetPlayer.CurrentPlanet.GenerationSeed + 223429);
    ReplaceTextToken(Text, '<Money>', WideString(IntToStr(Cost)), '<color=255,240,100>');
    DialogText := Text;
    ClearDialogChoices;
    if GetPlayer.Money >= Cost then
      AddChoice(FormatText2(PickLocalizedTextVariant('FormGov.Bribe.Ok', (Galaxy.CurrentTurn div 5) * GetPlayer.CurrentPlanet.GenerationSeed + 8168236),
        '<color=255,240,100>', '<Money>', WideString(IntToStr(Cost)), '<Planet>', GetPlayer.CurrentPlanet.Name), 0, PayBribe);
    AddChoice(PickLocalizedTextVariant('FormGov.Bribe.No', (Galaxy.CurrentTurn div 5) * GetPlayer.CurrentPlanet.GenerationSeed + 23985), 0, DeclineBribe);
  end
  else
  begin
    DialogText := PickLocalizedTextVariant('FormGov.Bribe.GotoPB', (Galaxy.CurrentTurn div 10) * GetPlayer.CurrentPlanet.GenerationSeed + 112);
    BuildGovernmentChoices(True);
  end;
end;
{ @end $52A668 }

{ @routine $52AA40 TfGov_PayBribe }
procedure TfGov.PayBribe(Action: Integer);
var Cost, RelationDeficit: Integer;
begin
    RelationDeficit := 100 - GetPlayer.CurrentPlanet.RelationToShip(GetPlayer);
    Cost := Round(RemapClamped(RelationDeficit, 0, 100, 1, 5) * (Galaxy.AverageRangerCapital div 100) *
      OwnerInfo[GetPlayer.CurrentPlanet.OwnerId].FuelPriceFactor);
  GetPlayer.SetMoney(GetPlayer.Money - Cost);
  SoundManager.PlaySound('Sound.Sell');
  if GetPlayer.CurrentPlanet.OwnerId = Byte(oiPirate) then
  begin
    if MainPiratePlanet <> nil then MainPiratePlanet.ChangeRelationToRanger(GetPlayer, 100)
    else GetPlayer.CurrentPlanet.ChangeRelationToRanger(GetPlayer, 100);
  end
  else
  begin
    GetPlayer.CurrentPlanet.ChangeRelationToRanger(GetPlayer, 100);
    GetPlayer.ChangePlanetRelations(GetPlayer.CurrentStar, rcmIncrease, 20, TOwnerMask(PlanetOwnerMasks.Coalition));
  end;
  DialogText := PickLocalizedTextVariant('FormGov.Bribe.QuestionOk', (Galaxy.CurrentTurn div 5) * GetPlayer.CurrentPlanet.GenerationSeed + 7156317);
  ReplaceTextToken(DialogText, '<Money>', WideString(IntToStr(Cost)), '<color=255,240,100>');
  ReplaceTextToken(DialogText, '<Planet>', GetPlayer.CurrentPlanet.Name, '<color=255,240,100>');
  BuildGovernmentChoices(True);
end;
{ @end $52AA40 }

{ @routine $52AD28 TfGov_DeclineBribe }
procedure TfGov.DeclineBribe(Action: Integer);
begin
  DialogText := PickLocalizedTextVariant('FormGov.Bribe.QuestionNo', (Galaxy.CurrentTurn div 5) * GetPlayer.CurrentPlanet.GenerationSeed + 92874253);
  BuildGovernmentChoices(True);
end;
{ @end $52AD28 }

{ @routine $52ADF4 TfGov_RequestQuest }
procedure TfGov.RequestQuest(Action: Integer);
var ResponseText: WideString; MapIndex, MapId: Integer;
begin
  if (GetPlayer.CurrentPlanet.CurrentStar.Battle <> 0) and (GetPlayer.CurrentPlanet.OwnerId = Byte(oiPirate)) then
  begin
    DialogText := PickLocalizedTextVariant('FormGov.DontQuest.WarInSystemPirate', (Galaxy.CurrentTurn div 5) * GetPlayer.CurrentPlanet.GenerationSeed + 118123);
    BuildGovernmentChoices(True);
  end
  else if GetPlayer.CurrentPlanet.CurrentStar.Battle <> 0 then
  begin
    DialogText := PickLocalizedTextVariant('FormGov.DontQuest.WarInSystem', (Galaxy.CurrentTurn div 5) * GetPlayer.CurrentPlanet.GenerationSeed + 118123);
    BuildGovernmentChoices(True);
  end
  else
  begin
    if GetPlayer.DeclinePlanetBattleOffers then MapId := -1
    else MapId := GetPlayer.SelectPlanetBattleMap;
    if (MapId >= 0) and (ForcedPlanetQuestId < 0) then
    begin
      MapIndex := FindRobotMapById(MapId);
      DialogText := RobotMapDefinitions[MapIndex].GovTextStart;
      ReplaceTextToken(DialogText, '<Star>', GetPlayer.CurrentStar.Name, '<color=255,240,100>');
      ReplaceTextToken(DialogText, '<Planet>', GetPlayer.CurrentPlanet.Name, '<color=255,240,100>');
      ReplaceTextToken(DialogText, '<Player>', GetPlayer.Name, '<color=255,240,100>');
      ClearDialogChoices;
      if (RobotInterface <> nil) and (RobotInterface.Support() = 0) then
        AddChoice(LocalizedColorText('FormGov.I_QuestAccept'), MapId, ShowPlanetBattleSupport)
      else AddChoice(LocalizedColorText('FormGov.I_QuestAccept'), 0, ScriptDialogBlockCallback);
      AddChoice(LocalizedColorText('FormGov.I_PlanetBattleQuestClose'), MapId, DeclinePlanetBattle);
      AddChoice(LocalizedColorText('FormGov.I_PlanetBattleRejectAll'), 0, ConfirmDeclineAllPlanetBattles);
      AddChoice(LocalizedColorText('FormGov.I_Exit'), 0, ReturnToPlanet);
    end
    else if not GetPlayer.GenerateQuestOffer(QuestOffer, ResponseText) then
    begin
      DialogText := ResponseText;
      BuildGovernmentChoices(True);
    end
    else
    begin
      QuestNegotiationLevel := 0;
      DialogText := GetPlayer.BuildQuestText(QuestOffer, qtkOffer);
      if (QuestOffer.QuestType = qtPlanetQuest) and (QuestOffer.QuestNumber >= 10000) then
        if (LanguageDataConfig.GetBlock('PlanetQuest').CountBlocks('PlanetQuestLic') <= 0) or
          (LanguageDataConfig.GetBlock('PlanetQuest').GetBlock('PlanetQuestLic').GetParamOrMarker(WideString(IntToStr(QuestOffer.QuestNumber))) <>
           PlanetQuestScreen.GetQuestContentHash(QuestOffer.QuestNumber)) then
          DialogText := DialogText + #13#10 + ' ' + #13#10 + LocalizedText('FormGov.QuestCertificate.NotCertificate');
      QuestRewardStep := Round(QuestOffer.RewardMoney * 0.3);
      QuestDurationStep := Round((QuestOffer.DeadlineTurn - Galaxy.CurrentTurn) * 0.5);
      BuildQuestOfferChoices;
    end;
  end;
end;
{ @end $52ADF4 }

{ @routine $52B518 TfGov_MakeQuestEasier }
procedure TfGov.MakeQuestEasier(Action: Integer);
begin
  Dec(QuestNegotiationLevel);
  case QuestOffer.QuestType of
    qtSendLetter..qtPlanetQuest: Inc(QuestOffer.DeadlineTurn, QuestDurationStep);
    qtDefendSystem..qtDefendShip: Dec(QuestOffer.DeadlineTurn, QuestDurationStep);
  end;
  Dec(QuestOffer.RewardMoney, QuestRewardStep);
  DialogText := LocalizedColorText('FormGov.CheckQuest.Easy') + #13#10 + GetPlayer.BuildQuestText(QuestOffer, qtkOffer);
  if QuestNegotiationLevel <= -1 then
  begin
    ClearDialogChoices;
    AddChoice(LocalizedColorText('FormGov.I_QuestAccept'), 0, AcceptQuest);
    AddChoice(LocalizedColorText('FormGov.I_QuestReject'), 0, RejectQuest);
    AddChoice(LocalizedColorText('FormGov.I_QuestDifficult'), 0, MakeQuestHarder);
    if QuestOffer.QuestType = qtPlanetQuest then
      AddChoice(LocalizedColorText('FormGov.I_PlanetQuestClose'), 0, PermanentlyDeclineQuest);
    AddChoice(LocalizedColorText('FormGov.I_Exit'), 0, ReturnToPlanet);
  end
  else BuildQuestOfferChoices;
end;
{ @end $52B518 }

{ @routine $52B810 TfGov_MakeQuestHarder }
procedure TfGov.MakeQuestHarder(Action: Integer);
begin
  Inc(QuestNegotiationLevel);
  case QuestOffer.QuestType of
    qtSendLetter..qtPlanetQuest: Dec(QuestOffer.DeadlineTurn, QuestDurationStep);
    qtDefendSystem..qtDefendShip: Inc(QuestOffer.DeadlineTurn, QuestDurationStep);
  end;
  Inc(QuestOffer.RewardMoney, QuestRewardStep);
  DialogText := LocalizedColorText('FormGov.CheckQuest.Difficult') + #13#10 + GetPlayer.BuildQuestText(QuestOffer, qtkOffer);
  if QuestNegotiationLevel >= 1 then
  begin
    ClearDialogChoices;
    AddChoice(LocalizedColorText('FormGov.I_QuestAccept'), 0, AcceptQuest);
    AddChoice(LocalizedColorText('FormGov.I_QuestReject'), 0, RejectQuest);
    AddChoice(LocalizedColorText('FormGov.I_QuestEasy'), 0, MakeQuestEasier);
    if QuestOffer.QuestType = qtPlanetQuest then
      AddChoice(LocalizedColorText('FormGov.I_PlanetQuestClose'), 0, PermanentlyDeclineQuest);
    AddChoice(LocalizedColorText('FormGov.I_Exit'), 0, ReturnToPlanet);
  end
  else BuildQuestOfferChoices;
end;
{ @end $52B810 }

{ @routine $52BB08 TfGov_AcceptQuest }
procedure TfGov.AcceptQuest(Action: Integer);
var Quest: PQuest; Item: TUselessItem;
begin
  New(Quest);
  Quest^ := QuestOffer;
  Quest.Description := GetPlayer.BuildQuestText(Quest^, qtkOffer);
  Quest.CompletionText := GetPlayer.BuildQuestText(Quest^, qtkCompletion);
  GetPlayer.Quests.Add(Quest);
  GetPlayer.PublishQuestStatus(Quest, 0);
  if Quest.QuestType = qtSendLetter then
  begin
    Item := TUselessItem.Create;
    Item.Init(LookupLocalizedTextByKey(WideString('Quest.SendLetter.' + IntToStr(Quest.QuestNumber) + '.SysName')), dsBlazer, 0, False);
    GetPlayer.Inventory.Add(Item);
  end;
  DialogText := PickLocalizedTextVariant('FormGov.AfterPlayerTakeQuest', (Galaxy.CurrentTurn div 10) * GetPlayer.CurrentPlanet.GenerationSeed + 902983);
  ClearDialogChoices;
  AddChoice(LocalizedColorText('FormGov.I_Exit'), 0, ReturnToPlanet);
end;
{ @end $52BB08 }

{ @routine $52BD7C TfGov_RejectQuest }
procedure TfGov.RejectQuest(Action: Integer);
begin
  DialogText := LocalizedColorText('FormGov.PlayerDontTakeQuest');
  ClearDialogChoices;
  AddChoice(LocalizedColorText('FormGov.I_Exit'), 0, ReturnToPlanet);
end;
{ @end $52BD7C }

{ @routine $52BE6C TfGov_PermanentlyDeclineQuest }
procedure TfGov.PermanentlyDeclineQuest(Action: Integer);
var Quest: PPlayerOldQuest;
begin
  DialogText := LocalizedColorText('FormGov.GovAfterPlanetQuestClose');
  New(Quest);
  Quest.QuestType := QuestOffer.QuestType;
  Quest.QuestNumber := QuestOffer.QuestNumber;
  Quest.Planet := QuestOffer.Planet;
  Quest.Description := 'PlanetQuestClose';
  Quest.Successful := False;
  Quest.Declined := True;
  PlayerOldQuests.Add(Quest);
  BuildGovernmentChoices(True);
end;
{ @end $52BE6C }

{ @routine $52BFB4 TfGov_DeclinePlanetBattle }
procedure TfGov.DeclinePlanetBattle(Action: Integer);
begin
  PlanetBattleMapId := Action;
  DialogText := LocalizedColorText('FormGov.GovAfterBattlePlanetQuestClose');
  SetLength(GetPlayer.PlanetBattleHistory, High(GetPlayer.PlanetBattleHistory) + 1 + 1);
  with GetPlayer.PlanetBattleHistory[High(GetPlayer.PlanetBattleHistory)] do
  begin
    MapId := PlanetBattleMapId;
    Statistics[0] := 0;
    Statistics[1] := 0;
    Statistics[2] := 0;
    Statistics[3] := 0;
    Statistics[4] := 0;
    Statistics[5] := 0;
    ResultCode := 1;
    CompletionMode := 0;
    DateTurn := Galaxy.CurrentTurn;
  end;
  GetPlayer.LastPlanetBattleTurn := Galaxy.CurrentTurn;
  BuildGovernmentChoices(True);
end;
{ @end $52BFB4 }

{ @routine $52C148 TfGov_ConfirmDeclineAllPlanetBattles }
procedure TfGov.ConfirmDeclineAllPlanetBattles(Action: Integer);
begin
  DialogText := LocalizedColorText('FormGov.I_PlanetBattleRejectAllConfirm');
  ClearDialogChoices;
  AddChoice(LocalizedColorText('FormGov.I_PlanetBattleRejectAllConfirmYes'), Action, DeclineAllPlanetBattles);
  AddChoice(LocalizedColorText('FormGov.I_PlanetBattleRejectAllConfirmNo'), Action, CancelDeclineAllPlanetBattles);
end;
{ @end $52C148 }

{ @routine $52C300 TfGov_DeclineAllPlanetBattles }
procedure TfGov.DeclineAllPlanetBattles(Action: Integer);
begin
  DialogText := LocalizedColorText('FormGov.I_PlanetBattleRejectAllConfirmAfterYes');
  GetPlayer.DeclinePlanetBattleOffers := True;
  BuildGovernmentChoices(True);
end;
{ @end $52C300 }

{ @routine $52C3D8 TfGov_CancelDeclineAllPlanetBattles }
procedure TfGov.CancelDeclineAllPlanetBattles(Action: Integer);
begin
  DialogText := LocalizedColorText('FormGov.I_PlanetBattleRejectAllConfirmAfterNo');
  BuildGovernmentChoices(True);
end;
{ @end $52C3D8 }

{ @routine $52C4A0 TfGov_ShowPlanetBattleSupport }
procedure TfGov.ShowPlanetBattleSupport(Action: Integer);
var MapIndex: Integer;
begin
  MapIndex := FindRobotMapById(Action);
  if RobotMapDefinitions[MapIndex].ReinforcementsDisabled then
    DialogText := PickLocalizedTextVariant('FormGov.PlanetBattle.GovBeforeBattleNoReinforcements', (Galaxy.CurrentTurn div 10) * GetPlayer.CurrentPlanet.GenerationSeed + 81263)
  else DialogText := PickLocalizedTextVariant('FormGov.PlanetBattle.GovBeforeBattle', (Galaxy.CurrentTurn div 10) * GetPlayer.CurrentPlanet.GenerationSeed + 81263);
  ClearDialogChoices;
  AddChoice(LocalizedColorText('FormGov.PlanetBattle.PlayerBeforeBattleNone'), Action, StartPlanetBattleWithoutSupport);
  if not RobotMapDefinitions[MapIndex].ReinforcementsDisabled then
    AddChoice(LocalizedColorText('FormGov.PlanetBattle.PlayerBeforeBattleHelp'), Action, StartPlanetBattleWithReinforcements);
  AddChoice(LocalizedColorText('FormGov.PlanetBattle.PlayerBeforeBattleDamage'), Action, StartPlanetBattleWithBombardment);
end;
{ @end $52C4A0 }

{ @routine $52C7FC TfGov_StartPlanetBattleWithoutSupport }
procedure TfGov.StartPlanetBattleWithoutSupport(Action: Integer);
begin
  CaptureSavePreview;
  CaptureGalaxyPreview(Self);
  SaveManagerReturnScreenId := FormToId(Self);
  SaveGameToFile(SaveManagerScreen.GetAutoSavePath, 'as');
  GovernmentBattleDifficulty := 1;
  PlanetBattleMapId := Action;
  PendingTransition := 1;
  RequestedScreenId := screenGovernment;
  LoadPanel.SelectBackgroundStyle(3);
  LoadPanel.RefreshBackgroundImages;
  LoadPanel.StartClosingShutters;
end;
{ @end $52C7FC }

{ @routine $52C8DC TfGov_StartPlanetBattleWithReinforcements }
procedure TfGov.StartPlanetBattleWithReinforcements(Action: Integer);
begin
  CaptureSavePreview;
  CaptureGalaxyPreview(Self);
  SaveManagerReturnScreenId := FormToId(Self);
  SaveGameToFile(SaveManagerScreen.GetAutoSavePath, 'as');
  GovernmentBattleDifficulty := 2;
  PlanetBattleMapId := Action;
  PendingTransition := 1;
  RequestedScreenId := screenGovernment;
  LoadPanel.SelectBackgroundStyle(3);
  LoadPanel.RefreshBackgroundImages;
  LoadPanel.StartClosingShutters;
end;
{ @end $52C8DC }

{ @routine $52C9BC TfGov_StartPlanetBattleWithBombardment }
procedure TfGov.StartPlanetBattleWithBombardment(Action: Integer);
begin
  CaptureSavePreview;
  CaptureGalaxyPreview(Self);
  SaveManagerReturnScreenId := FormToId(Self);
  SaveGameToFile(SaveManagerScreen.GetAutoSavePath, 'as');
  GovernmentBattleDifficulty := 3;
  PlanetBattleMapId := Action;
  PendingTransition := 1;
  RequestedScreenId := screenGovernment;
  LoadPanel.SelectBackgroundStyle(3);
  LoadPanel.RefreshBackgroundImages;
  LoadPanel.StartClosingShutters;
end;
{ @end $52C9BC }

{ @routine $52CA9C TfGov_DeclineBattleAndLeave }
procedure TfGov.DeclineBattleAndLeave(Action: Integer);
begin
  DialogText := PickLocalizedTextVariant('FormGov.PlanetBattle.GovBeforeNormal', (Galaxy.CurrentTurn div 10) * GetPlayer.CurrentPlanet.GenerationSeed + 81263);
  ClearDialogChoices;
  AddChoice(LocalizedColorText('FormGov.I_Exit'), 0, ReturnToPlanet);
end;
{ @end $52CA9C }

{ @routine $52CBCC TfGov_ChoosePrisonInsteadOfBattle }
procedure TfGov.ChoosePrisonInsteadOfBattle(Action: Integer);
begin
  GetPlayer.CurrentPlanet.SetRelationLevelToRanger(GetPlayer, rlHostile);
  if GetPlayer.CurrentPlanet.OwnerId = Byte(oiPirate) then
  begin
    DialogText := PickLocalizedTextVariant('FormGov.PlanetBattle.GovBeforePrisonPirateClan', (Galaxy.CurrentTurn div 10) * GetPlayer.CurrentPlanet.GenerationSeed + 81263);
    ClearDialogChoices;
    AddChoice(PickLocalizedTextVariant('FormGov.PlanetBattle.PlayerGoToPrisonPirateClan', (Galaxy.CurrentTurn div 10) * GetPlayer.CurrentPlanet.GenerationSeed + 61253), 0, EnterPrison);
  end
  else
  begin
    DialogText := PickLocalizedTextVariant('FormGov.PlanetBattle.GovBeforePrison', (Galaxy.CurrentTurn div 10) * GetPlayer.CurrentPlanet.GenerationSeed + 81263);
    ClearDialogChoices;
    AddChoice(PickLocalizedTextVariant('FormGov.PlanetBattle.PlayerGoToPrison', (Galaxy.CurrentTurn div 10) * GetPlayer.CurrentPlanet.GenerationSeed + 61253), 0, EnterPrison);
  end;
end;
{ @end $52CBCC }

{ @routine $52CEDC TfGov_ShowMapOffer }
procedure TfGov.ShowMapOffer(Action: Integer);
var Cost: Integer;
begin
  Cost := RoundAndTruncateToTens(Min(GetPlayer.Wealth div 40, Galaxy.ComputeScaledBigMoney(GetPlayer.CurrentPlanet.OwnerId)) + 50);
  DialogText := FormatText2(PickLocalizedTextVariant('FormGov.BuyMap.GovAsk', (Galaxy.CurrentTurn div 10) * GetPlayer.CurrentPlanet.GenerationSeed), '<color=255,240,100>', '<Name>',
    (TObject(GetPlayer.CurrentPlanet.FindUnchartedNeighborConstellation) as TConstellation).GetName,
    '<Money>', WideString(IntToStr(Cost)));
  ClearDialogChoices;
  if GetPlayer.Money >= Cost then
    AddChoice(LocalizedColorText('FormGov.BuyMap.PlayerOk'), 0, BuyMap);
  AddChoice(LocalizedColorText('FormGov.BuyMap.PlayerNO'), 0, DeclineMapOffer);
end;
{ @end $52CEDC }

{ @routine $52D190 TfGov_BuyMap }
procedure TfGov.BuyMap(Action: Integer);
var Cost: Integer;
begin
  Cost := RoundAndTruncateToTens(Min(GetPlayer.Wealth div 40, Galaxy.ComputeScaledBigMoney(GetPlayer.CurrentPlanet.OwnerId)) + 50);
  GetPlayer.SetMoney(GetPlayer.Money - Cost);
  (TObject(GetPlayer.CurrentPlanet.FindUnchartedNeighborConstellation) as TConstellation).Visible := True;
  GetPlayer.AchievementStats.CheckMapBuilderAchievement;
  SoundManager.PlaySound('Sound.Sell');
  DialogText := PickLocalizedTextVariant('FormGov.BuyMap.GovAfterOk', (Galaxy.CurrentTurn div 10) * GetPlayer.CurrentPlanet.GenerationSeed + 711);
  BuildGovernmentChoices(True);
end;
{ @end $52D190 }

{ @routine $52D330 TfGov_DeclineMapOffer }
procedure TfGov.DeclineMapOffer(Action: Integer);
begin
  DialogText := PickLocalizedTextVariant('FormGov.BuyMap.GovAfterNo', (Galaxy.CurrentTurn div 10) * GetPlayer.CurrentPlanet.GenerationSeed + 112);
  BuildGovernmentChoices(True);
end;
{ @end $52D330 }

{ @routine $52D3F8 TfGov_ShowPrisonBail }
procedure TfGov.ShowPrisonBail(Action: Integer);
var Text, RowText: WideString; Ship: TShip; I, Cost: Integer; Ships: TList;
begin
  DialogText := LocalizedColorText('FormGov.GuarantPrison.PlanetAsk');
  Text := '';
  Ships := TList.Create;
  for I := 0 to GetPlayer.CurrentStar.Ships.Count - 1 do
  begin
    Ship := GetPlayer.CurrentStar.Ships[I];
    if (GetPlayer.CurrentPlanet = Ship.CurrentPlanet) and
      ((Ship.ScriptShip = nil) or ((Ship.ScriptShip as TScriptShip).State.StateKind = sskNormalAI)) and
      Ship.IsInPrison and (Ship.GetPrisonTermRemaining > 0) then
    begin
      RowText := FormatText2(LocalizedColorText('FormGov.GuarantPrison.ShipRow'), '<color=255,240,100>',
        '<Ship>', Ship.GetFullName(' '), '<Cost>', WideString(IntToStr(Ship.GetPrisonReleaseCost)));
      Text := Text + #13#10 + ' - ' + RowText;
      Ships.Add(Ship);
    end;
  end;
  DialogText := DialogText + Text;
  ClearDialogChoices;
  for I := 0 to Ships.Count - 1 do
  begin
    Ship := Ships[I];
    if Ship.IsInPrison then
    begin
      Cost := Ship.GetPrisonReleaseCost;
      Text := LocalizedColorText('FormGov.GuarantPrison.PlayerOk');
      Text := FormatText2(Text, '<color=255,240,100>', '<Ship>', Ship.GetFullName(' '),
        '<Cost>', WideString(IntToStr(Cost)));
      if GetPlayer.Money >= Cost then AddChoice(Text, Integer(Ship), PayPrisonBail)
      else AddChoice(Text, 0, ScriptDialogBlockCallback);
    end;
  end;
  AddChoice(LocalizedColorText('FormGov.GuarantPrison.PlayerNo'), 0, CancelPrisonBail);
  Ships.Free;
end;
{ @end $52D3F8 }

{ @routine $52D888 TfGov_PayPrisonBail }
procedure TfGov.PayPrisonBail(Action: Integer);
var Ship: TShip;
begin
  Ship := TShip(Action);
  if Ship.IsInPrison then
  begin
    GetPlayer.SetMoney(Max(0, GetPlayer.Money - Ship.GetPrisonReleaseCost));
    Ship.ClearPrisonTerm;
    Ship.ChangeRelationToRanger(GetPlayer, 100);
    Ship.OrderTakeoff;
    Inc(GetPlayer.AchievementStats.PrisonersBailedOut);
    TrySetAchievementProgress('PRISONBAIL', GetPlayer.AchievementStats.PrisonersBailedOut);
  end;
  SoundManager.PlaySound('Sound.Sell');
  DialogText := LocalizedColorText('FormGov.GuarantPrison.PlanetAfterOk');
  BuildGovernmentChoices(True);
end;
{ @end $52D888 }

{ @routine $52DA28 TfGov_CancelPrisonBail }
procedure TfGov.CancelPrisonBail(Action: Integer);
begin
  DialogText := LocalizedColorText('FormGov.GuarantPrison.PlanetAfterNo');
  BuildGovernmentChoices(True);
end;
{ @end $52DA28 }

{ @routine $52DADC TfGov_ReturnToPlanet }
procedure TfGov.ReturnToPlanet(Action: Integer);
begin
  RequestedScreenId := screenPlanet;
  RequestClose(1);
end;
{ @end $52DADC }

{ @routine $52DB04 TfGov_ExitGovernment }
procedure TfGov.ExitGovernment(Action: Integer);
begin
  RequestedScreenId := screenPlanet;
  RequestClose(1);
end;
{ @end $52DB04 }

{ @routine $52DB2C TfGov_RunInjectedAnswer }
procedure TfGov.RunInjectedAnswer(Answer: Integer);
var Injection: PScriptDialogInjection; Text: WideString; PartCount: Integer;
  Item: TEquipment;
  Ship: TShip;
  ItemType: Byte;
  Cost: Integer;
  TechLevel: Byte;
  Owner: Byte;
  I, CoalitionCount, RemoteAction, RemoteIndex, OrderCompleteTurn: Integer;
  StrategyPayload, StrategyOrderCode, StrategySpecialization, StrategyLevel: Integer;
  DevelopmentCost, DevelopmentDays: Integer;
  ScienceLevel, IndustryLevel, ProductionAmount, DevelopmentSpecialization, ActiveDefenders: Integer;
  Prototype: Boolean;
  Planet: TPlanet;
  TargetStar: TStar;
  Fleet: TGroup;
  FleetMode, StarIndex, Available, FleetSize: Integer;
  StrategicScreen: TStrategicScreen;
  CursorState: TCursorStateGI;
  ScreenResult: Cardinal;
begin
  if Answer = -10200 then
  begin
    RootUiObject.NativeHook50;
    CaptureCursorState(@CursorState);
    SetCursorActive(False);
    DrawQueuedUpdateRects;
    CaptureScreenBackground(False, 0);
    StrategicScreen := TStrategicScreen.Create;
    StrategicScreen.ParentLoop := Self;
    ChildLoop := StrategicScreen;
    StrategicScreen.InitializeDefaults;
    StrategicScreen.Gov := Self;
    try
      ScreenResult := StrategicScreen.Run;
      InvalidateViewport;
    finally
      ChildLoop := nil;
      StrategicScreen.Free;
    end;
    RestoreCursorState(@CursorState);
    UpdateCursorPosition;
    RootUiObject.NativeHook48;
    if ScreenResult = 254 then BreakUiMessage;
    Exit;
  end;
  if (Answer <= -100000) and (Answer > -2100000) then
  begin
    I := (-100000 - Answer) div 2000;
    FleetMode := ((-100000 - Answer) mod 2000) div 1000;
    StarIndex := (-100000 - Answer) mod 1000;
    if (I >= Galaxy.Planets.Count) or (StarIndex >= Galaxy.Stars.Count) then Exit;
    Planet := TPlanet(Galaxy.Planets[I]);
    TargetStar := TStar(Galaxy.Stars[StarIndex]);
    if not Planet.IsCoalitionOwned or (TargetStar = Planet.CurrentStar) then Exit;
    Fleet := TGroup.Create;
    Galaxy.LiberationGroups.Add(Fleet);
    Fleet.GenerationSeed := StrategicFleetSeed;
    SetLength(Fleet.Route, 4);
    Fleet.Route[0].Kind := 3; Fleet.Route[0].Target := Planet.CurrentStar;
    Fleet.Route[1].Kind := 3; Fleet.Route[1].Target := Planet.CurrentStar;
    Fleet.Route[2].Kind := 3; Fleet.Route[2].Target := Planet.CurrentStar;
    Fleet.Route[3].Kind := 3; Fleet.Route[3].Target := TargetStar;
    FleetSize := 0;
    for RemoteIndex := 0 to Planet.Warriors.Count - 1 do
    begin
      Ship := TShip(Planet.Warriors[RemoteIndex]);
      if ((Ship.CurrentPlanet = Planet) or
          (Ship.InNormalSpace and (Ship.CurrentStar = Planet.CurrentStar) and (Ship.Order in [soNone, soMove]))) and (Ship.ScriptShip = nil) and
         (Ship.AbsoluteScriptOrder = 0) and (Ship.LiberationGroup = nil) and
         (Ship.GetFuelLimitedJumpRange >= Round(PointDistance(Planet.CurrentStar.Position, TargetStar.Position))) then
      begin
        if Planet.CurrentStar.Ships.IndexOf(Ship) < 0 then Planet.CurrentStar.Ships.Add(Ship);
        Fleet.AddShip(Ship);
        if Ship.CurrentPlanet = Planet then Ship.OrderTakeoff else Ship.OrderNone(False);
        Inc(FleetSize);
        if (FleetMode = 0) or (FleetSize >= 30) then Break;
      end;
    end;
    if FleetSize = 0 then
    begin
      Fleet.Disband;
      DialogText := 'Нет свободных кораблей с достаточным запасом топлива и дальностью прыжка до выбранной системы.';
    end
    else DialogText := 'Флот отправлен из системы ' + Planet.CurrentStar.Name + ' в систему ' + TargetStar.Name +
      '. Кораблей: ' + IntToStr(FleetSize) + '. После прибытия они будут патрулировать систему до приказа об отзыве.';
    if not DirectStrategicCall then begin
      ClearDialogChoices;
      AddChoice('Вернуться к планете', -11000 - I, RunInjectedAnswer);
      AddChoice('К списку планет', -10100, RunInjectedAnswer);
    end;
    Exit;
  end;
  if (Answer <= -30000) and (Answer > -32000) then
  begin
    I := (-30000 - Answer) div 2;
    FleetMode := (-30000 - Answer) mod 2;
    if I >= Galaxy.Planets.Count then Exit;
    Planet := TPlanet(Galaxy.Planets[I]);
    if not Planet.IsCoalitionOwned then Exit;
    DialogText := 'Выберите систему назначения для экспедиции с планеты ' + Planet.GetFullName(' ') +
      '. Показывается число доступных кораблей, способных совершить прямой прыжок.';
    ClearDialogChoices;
    for StarIndex := 0 to Galaxy.Stars.Count - 1 do
    begin
      if StarIndex >= 1000 then Break;
      TargetStar := TStar(Galaxy.Stars[StarIndex]);
      if TargetStar = Planet.CurrentStar then Continue;
      Available := 0;
      for RemoteIndex := 0 to Planet.Warriors.Count - 1 do
      begin
        Ship := TShip(Planet.Warriors[RemoteIndex]);
        if ((Ship.CurrentPlanet = Planet) or
            (Ship.InNormalSpace and (Ship.CurrentStar = Planet.CurrentStar) and (Ship.Order in [soNone, soMove]))) and (Ship.ScriptShip = nil) and
           (Ship.AbsoluteScriptOrder = 0) and (Ship.LiberationGroup = nil) and
           (Ship.GetFuelLimitedJumpRange >= Round(PointDistance(Planet.CurrentStar.Position, TargetStar.Position))) then Inc(Available);
      end;
      if Available > 0 then AddChoice(TargetStar.Name + ' — доступно: ' + IntToStr(Available),
        -100000 - I * 2000 - FleetMode * 1000 - StarIndex, RunInjectedAnswer);
    end;
    AddChoice('Вернуться к планете', -11000 - I, RunInjectedAnswer);
    Exit;
  end;
  if Answer = -10100 then
  begin
    CoalitionCount := 0;
    DialogText := 'Стратегическое командование Коалиции.' + #13#10 +
      'Выберите планету для удалённого управления. Сейчас доступны все планеты Коалиции; позднее доступ будет зависеть от связи, контроля системы и назначенных губернаторов.';
    ClearDialogChoices;
    for I := 0 to Galaxy.Planets.Count - 1 do
    begin
      Planet := TPlanet(Galaxy.Planets[I]);
      if Planet.IsCoalitionOwned then
      begin
        Inc(CoalitionCount);
        AddChoice(Planet.GetFullName(' ') + ' — ' + Planet.CurrentStar.Name +
          '; бюджет ' + IntToStr(Planet.Money) + ' cr.; гарнизон ' + IntToStr(Planet.Warriors.Count), -11000 - I, RunInjectedAnswer);
      end;
    end;
    if CoalitionCount = 0 then
      DialogText := DialogText + #13#10 + 'Доступных планет Коалиции пока нет.';
    AddChoice('Назад к правительству', -10099, RunInjectedAnswer);
    Exit;
  end;
  if (Answer <= -11000) and (Answer > -12000) then
  begin
    I := -11000 - Answer;
    if (I >= 0) and (I < Galaxy.Planets.Count) then
    begin
      Planet := TPlanet(Galaxy.Planets[I]);
      if Planet.IsCoalitionOwned then
      begin
        ActiveDefenders := 0;
        for RemoteIndex := 0 to Planet.Warriors.Count - 1 do
          if TShip(Planet.Warriors[RemoteIndex]).CurrentPlanet = nil then Inc(ActiveDefenders);
        DialogText := Planet.GetFullName(' ') + ' в системе ' + Planet.CurrentStar.Name + '.' + #13#10 +
          'Бюджет: ' + IntToStr(Planet.Money) + ' cr.; население: ' + IntToStr(Planet.Population) +
          '; гарнизон: ' + IntToStr(Planet.Warriors.Count) + ', в космосе: ' + IntToStr(ActiveDefenders) + '.' + #13#10 +
          'Двигатели L' + IntToStr(Planet.InventionLevels[2]) +
          '; защита и оружие L' + IntToStr(Planet.InventionLevels[7]) + '.';
        StrategyPayload := 0;
        StrategyOrderCode := 0;
        StrategySpecialization := StrategySpecializationNone;
        StrategyLevel := 0;
        if (Planet.ReservedSaveValue >= StrategyOrderMarker) and
           (Planet.ReservedSaveValue < StrategyOrderMarker + 500000000) then
        begin
          StrategyPayload := Planet.ReservedSaveValue - StrategyOrderMarker;
          OrderCompleteTurn := StrategyPayload div StrategyOrderTurnFactor;
          StrategyOrderCode := StrategyPayload mod StrategyOrderCodeFactor;
          StrategySpecialization := (StrategyPayload div StrategyOrderSpecializationFactor) mod 8;
          StrategyLevel := (StrategyPayload div StrategyOrderLevelFactor) mod 4;
        end;
        if StrategySpecialization = StrategySpecializationScience then
          DialogText := DialogText + #13#10 + 'Научная ветка: уровень ' + IntToStr(StrategyLevel) + ' из 3.';
        if StrategySpecialization = StrategySpecializationIndustry then
          DialogText := DialogText + #13#10 + 'Промышленная ветка: уровень ' + IntToStr(StrategyLevel) + ' из 3.';
        if StrategyOrderCode <> 0 then
        begin
          DialogText := DialogText + #13#10 + 'Активный стратегический заказ завершится в день ' + IntToStr(OrderCompleteTurn) + '.';
        end
        else
          DialogText := DialogText + #13#10 + 'Очередь производства свободна.';
        ClearDialogChoices;
        AddChoice('Заказать продовольствие (+100, 400 cr., 2 дня)', -20000 - I * 10 - 1, RunInjectedAnswer);
        AddChoice('Исследовать двигатели (+1 уровень, 25000 cr., 7 дней)', -20000 - I * 10 - 2, RunInjectedAnswer);
        AddChoice('Исследовать защиту и оружие (+1 уровень, 40000 cr., 10 дней)', -20000 - I * 10 - 3, RunInjectedAnswer);
        AddChoice('Построить защитника (30000 cr., 12 дней)', -20000 - I * 10 - 4, RunInjectedAnswer);
        if (StrategySpecialization in [StrategySpecializationNone, StrategySpecializationScience]) and (StrategyLevel < 3) then
          AddChoice('Развивать научную ветку до уровня ' + IntToStr(StrategyLevel + 1), -20000 - I * 10 - 5, RunInjectedAnswer);
        if (StrategySpecialization in [StrategySpecializationNone, StrategySpecializationIndustry]) and (StrategyLevel < 3) then
          AddChoice('Развивать промышленную ветку до уровня ' + IntToStr(StrategyLevel + 1), -20000 - I * 10 - 6, RunInjectedAnswer);
        AddChoice('Поднять гарнизон на оборону системы', -20000 - I * 10 - 7, RunInjectedAnswer);
        AddChoice('Вернуть гарнизон на планету', -20000 - I * 10 - 8, RunInjectedAnswer);
        AddChoice('Отправить один корабль в другую систему', -30000 - I * 2, RunInjectedAnswer);
        AddChoice('Отправить флот в другую систему (до 30 кораблей)', -30001 - I * 2, RunInjectedAnswer);
        AddChoice('Отозвать назначенные флоты на родную планету', -20000 - I * 10 - 9, RunInjectedAnswer);
        AddChoice('К списку планет', -10100, RunInjectedAnswer);
        AddChoice('Назад к правительству', -10099, RunInjectedAnswer);
        Exit;
      end;
    end;
  end;
  if (Answer <= -20001) and (Answer > -30000) then
  begin
    RemoteIndex := (-20000 - Answer) div 10;
    RemoteAction := (-20000 - Answer) mod 10;
    if (RemoteIndex < 0) or (RemoteIndex >= Galaxy.Planets.Count) then Exit;
    Planet := TPlanet(Galaxy.Planets[RemoteIndex]);
    if not Planet.IsCoalitionOwned then Exit;
    StrategyPayload := 0;
    StrategyOrderCode := 0;
    StrategySpecialization := StrategySpecializationNone;
    StrategyLevel := 0;
    if (Planet.ReservedSaveValue >= StrategyOrderMarker) and
       (Planet.ReservedSaveValue < StrategyOrderMarker + 500000000) then
    begin
      StrategyPayload := Planet.ReservedSaveValue - StrategyOrderMarker;
      StrategyOrderCode := StrategyPayload mod StrategyOrderCodeFactor;
      StrategySpecialization := (StrategyPayload div StrategyOrderSpecializationFactor) mod 8;
      StrategyLevel := (StrategyPayload div StrategyOrderLevelFactor) mod 4;
    end;
    ScienceLevel := 0;
    IndustryLevel := 0;
    if StrategySpecialization = StrategySpecializationScience then ScienceLevel := StrategyLevel;
    if StrategySpecialization = StrategySpecializationIndustry then IndustryLevel := StrategyLevel;
    if (StrategyOrderCode <> 0) and (RemoteAction <= 6) then
      DialogText := 'Нельзя поставить заказ: очередь производства этой планеты занята.'
    else
    case RemoteAction of
      1:
        if Planet.Money < 400 then DialogText := 'Недостаточно средств в бюджете планеты.'
        else begin Dec(Planet.Money, 400); Planet.ReservedSaveValue := StrategyOrderMarker + (Galaxy.CurrentTurn + 2) * StrategyOrderTurnFactor + StrategySpecialization * StrategyOrderSpecializationFactor + StrategyLevel * StrategyOrderLevelFactor + StrategyOrderFood; DialogText := 'Заказ принят: продовольствие будет готово в день ' + IntToStr(Galaxy.CurrentTurn + 2) + '.'; end;
      2:
        if Planet.Money < 25000 then DialogText := 'Недостаточно средств в бюджете планеты.'
        else if Planet.InventionLevels[2] >= 8 then DialogText := 'Технология двигателей уже достигла L8.'
        else begin Dec(Planet.Money, 25000); Planet.ReservedSaveValue := StrategyOrderMarker + (Galaxy.CurrentTurn + 7 - ScienceLevel) * StrategyOrderTurnFactor + StrategySpecialization * StrategyOrderSpecializationFactor + StrategyLevel * StrategyOrderLevelFactor + StrategyOrderEngineResearch; DialogText := 'Заказ принят: технология двигателей будет повышена в день ' + IntToStr(Galaxy.CurrentTurn + 7 - ScienceLevel) + '.'; end;
      3:
        if Planet.Money < 40000 then DialogText := 'Недостаточно средств в бюджете планеты.'
        else if Planet.InventionLevels[7] >= 8 then DialogText := 'Главная технология уже достигла L8.'
        else begin Dec(Planet.Money, 40000); Planet.ReservedSaveValue := StrategyOrderMarker + (Galaxy.CurrentTurn + 10 - ScienceLevel) * StrategyOrderTurnFactor + StrategySpecialization * StrategyOrderSpecializationFactor + StrategyLevel * StrategyOrderLevelFactor + StrategyOrderMainResearch; DialogText := 'Заказ принят: технология будет повышена в день ' + IntToStr(Galaxy.CurrentTurn + 10 - ScienceLevel) + '.'; end;
      4:
        begin
          DevelopmentCost := 30000 - IndustryLevel * 3000;
          DevelopmentDays := 12 - IndustryLevel;
          if Planet.Money < DevelopmentCost then DialogText := 'Недостаточно средств в бюджете планеты.'
        else
        begin
          Dec(Planet.Money, DevelopmentCost);
          Planet.ReservedSaveValue := StrategyOrderMarker + (Galaxy.CurrentTurn + DevelopmentDays) * StrategyOrderTurnFactor + StrategySpecialization * StrategyOrderSpecializationFactor + StrategyLevel * StrategyOrderLevelFactor + StrategyOrderDefender;
          DialogText := 'Заказ принят: защитник будет добавлен в гарнизон в день ' + IntToStr(Galaxy.CurrentTurn + DevelopmentDays) + '.';
        end;
        end;
      5, 6:
        begin
          if RemoteAction = 5 then DevelopmentSpecialization := StrategySpecializationScience
          else DevelopmentSpecialization := StrategySpecializationIndustry;
        if not (StrategySpecialization in [StrategySpecializationNone, DevelopmentSpecialization]) then
          DialogText := 'Эта планета уже развивает другую ветку.'
        else if StrategyLevel >= 3 then
          DialogText := 'Эта ветка уже достигла максимального уровня III.'
        else
        begin
          case StrategyLevel + 1 of
            1: begin DevelopmentCost := 50000; DevelopmentDays := 8; end;
            2: begin DevelopmentCost := 100000; DevelopmentDays := 15; end;
          else begin DevelopmentCost := 180000; DevelopmentDays := 25; end;
          end;
          if Planet.Money < DevelopmentCost then
            DialogText := 'Недостаточно средств в бюджете планеты. Нужно: ' + IntToStr(DevelopmentCost) + ' cr.'
          else
          begin
            Dec(Planet.Money, DevelopmentCost);
            Planet.ReservedSaveValue := StrategyOrderMarker + (Galaxy.CurrentTurn + DevelopmentDays) * StrategyOrderTurnFactor +
              DevelopmentSpecialization * StrategyOrderSpecializationFactor + (StrategyLevel + 1) * StrategyOrderLevelFactor + StrategyOrderScienceDevelopment;
            DialogText := 'Проект ветки развития принят. Уровень ' + IntToStr(StrategyLevel + 1) +
              ' станет активен в день ' + IntToStr(Galaxy.CurrentTurn + DevelopmentDays) + '.';
          end;
        end;
        end;
      7:
        begin
          ActiveDefenders := 0;
          for I := 0 to Planet.Warriors.Count - 1 do
          begin
            Ship := TShip(Planet.Warriors[I]);
            if (Ship.CurrentPlanet = Planet) and (Ship.LiberationGroup = nil) then
            begin
              if Planet.CurrentStar.Ships.IndexOf(Ship) = -1 then Planet.CurrentStar.Ships.Add(Ship);
              Ship.OrderTakeoff;
              Inc(ActiveDefenders);
            end;
          end;
          DialogText := 'Приказ обороны передан. В космос поднято кораблей: ' + IntToStr(ActiveDefenders) + '.';
        end;
      8:
        begin
          ActiveDefenders := 0;
          for I := 0 to Planet.Warriors.Count - 1 do
          begin
            Ship := TShip(Planet.Warriors[I]);
            if (Ship.CurrentPlanet <> Planet) and (Ship.LiberationGroup = nil) then
            begin
              if Ship.CurrentStar = Planet.CurrentStar then Ship.OrderLanding(Planet, True)
              else TWarrior(Ship).NavigateToHomePlanet;
              Inc(ActiveDefenders);
            end;
          end;
          DialogText := 'Приказ возвращения передан кораблям: ' + IntToStr(ActiveDefenders) + '.';
        end;
      9:
        begin
          ActiveDefenders := 0;
          for I := 0 to Planet.Warriors.Count - 1 do
          begin
            Ship := TShip(Planet.Warriors[I]);
            if (Ship.LiberationGroup <> nil) and TGroup(Ship.LiberationGroup).IsStrategicFleet then
            begin
              Fleet := TGroup(Ship.LiberationGroup);
              Fleet.Route[2].WaitMode := 42;
              Fleet.Route[3].Target := Planet.CurrentStar;
              Ship.LiberationGroupRouteIndex := 3;
              if Ship.InNormalSpace and not (Ship.Order in [soJump, soLand]) then Ship.OrderNone(False);
              Inc(ActiveDefenders);
            end;
          end;
          DialogText := 'Приказ возвращения передан кораблям: ' + IntToStr(ActiveDefenders) +
            '. Они сохранят приказ во время боя и при необходимости сначала пополнят топливо.';
        end;
    end;
    if not DirectStrategicCall then begin
      ClearDialogChoices;
      AddChoice('Вернуться к планете', -11000 - RemoteIndex, RunInjectedAnswer);
      AddChoice('К списку планет', -10100, RunInjectedAnswer);
      AddChoice('Назад к правительству', -10099, RunInjectedAnswer);
    end;
    Exit;
  end;
  Planet := GetPlayer.CurrentPlanet;
  ScienceLevel := 0;
  IndustryLevel := 0;
  if (Planet.ReservedSaveValue >= StrategyOrderMarker) and
     (Planet.ReservedSaveValue < StrategyOrderMarker + 500000000) then
  begin
    StrategyPayload := Planet.ReservedSaveValue - StrategyOrderMarker;
    StrategyOrderCode := StrategyPayload mod StrategyOrderCodeFactor;
    StrategySpecialization := (StrategyPayload div StrategyOrderSpecializationFactor) mod 8;
    StrategyLevel := (StrategyPayload div StrategyOrderLevelFactor) mod 4;
    if (StrategySpecialization = StrategySpecializationScience) and (StrategyOrderCode = 0) then
      ScienceLevel := StrategyLevel;
    if (StrategySpecialization = StrategySpecializationIndustry) and (StrategyOrderCode = 0) then
      IndustryLevel := StrategyLevel;
  end;
  if Answer <= -10000 then
  begin
    if Answer = -10000 then
    begin
      DialogText := 'Управление планетой.' + #13#10 +
        Planet.GetFullName(' ') + ' в системе ' + Planet.CurrentStar.Name + '.' + #13#10 +
        'Бюджет планеты: ' + IntToStr(Planet.Money) + ' cr.' + #13#10 +
        'Население: ' + IntToStr(Planet.Population) +
        ', день галактики: ' + IntToStr(Galaxy.CurrentTurn) + '.' + #13#10 +
        'Технологии: двигатель L' + IntToStr(Planet.InventionLevels[2]) +
        '; защита L' + IntToStr(Planet.InventionLevels[7]) +
        '; оружие L' + IntToStr(Planet.InventionLevels[7]) + '.' + #13#10 +
        'Научная ветка: уровень ' + IntToStr(ScienceLevel) + ' из 3.' + #13#10 +
        'Промышленная ветка: уровень ' + IntToStr(IndustryLevel) + ' из 3.' + #13#10 +
        'Производство расходует бюджет самой планеты. Созданное оборудование получает указанный уровень технологии.';
      ClearDialogChoices;
      AddChoice('Произвести продовольствие (+100, 400 cr.)', -10001, RunInjectedAnswer);
      AddChoice('Произвести медикаменты (+100, 800 cr.)', -10002, RunInjectedAnswer);
      AddChoice('Произвести технику (+100, 1200 cr.)', -10003, RunInjectedAnswer);
      AddChoice('Произвести оружие (+100, 1600 cr.)', -10004, RunInjectedAnswer);
      AddChoice('Изготовить двигатель для магазина (5000 cr.)', -10010, RunInjectedAnswer);
      AddChoice('Изготовить генератор защиты для магазина (6500 cr.)', -10011, RunInjectedAnswer);
      AddChoice('Изготовить оружие для магазина (8000 cr.)', -10012, RunInjectedAnswer);
      AddChoice('Исследовать двигатели (+1 уровень, 25000 cr.)', -10015, RunInjectedAnswer);
      AddChoice('Исследовать защиту и оружие (+1 уровень, 40000 cr.)', -10016, RunInjectedAnswer);
      AddChoice('Построить гарнизонный корабль...', -10020, RunInjectedAnswer);
      AddChoice('Назад', -10099, RunInjectedAnswer);
      Exit;
    end;
    Cost := 0;
    case Answer of
      -10001: Cost := 400;
      -10002: Cost := 800;
      -10003: Cost := 1200;
      -10004: Cost := 1600;
      -10010: Cost := 5000;
      -10011: Cost := 6500;
      -10012: Cost := 8000;
      -10015: Cost := 25000;
      -10016: Cost := 40000;
      -10021: Cost := 15000;
      -10022: Cost := 30000;
    end;
    if (Answer >= -10012) and (Answer <= -10010) then Cost := Cost - Cost * IndustryLevel div 10;
    if (Answer >= -10022) and (Answer <= -10021) then Cost := Cost - Cost * IndustryLevel div 10;
    if (Cost > 0) and (Planet.Money < Cost) then
    begin
      DialogText := 'Недостаточно средств в бюджете планеты. Нужно: ' + IntToStr(Cost) +
        ' cr., доступно: ' + IntToStr(Planet.Money) + ' cr.';
      ClearDialogChoices;
      AddChoice('Продолжить управление', -10000, RunInjectedAnswer);
      AddChoice('Назад к правительству', -10099, RunInjectedAnswer);
      Exit;
    end;
    if Cost > 0 then Dec(Planet.Money, Cost);
    if (Answer >= -10004) and (Answer <= -10001) then
    begin
      case Answer of
        -10001: ItemType := Ord(t_Food);
        -10002: ItemType := Ord(t_Medicine);
        -10003: ItemType := Ord(t_Technics);
      else ItemType := Ord(t_Arms);
      end;
      ProductionAmount := 100 + IndustryLevel * 25;
      Inc(Planet.Goods[ItemType].Count, ProductionAmount);
      Planet.GoodsScarcityTicks[ItemType] := 0;
      Planet.GoodsSurplusTicks[ItemType] := 0;
      DialogText := 'Производство завершено: на рынок добавлено ' + IntToStr(ProductionAmount) + ' единиц товара.';
    end
    else if (Answer >= -10012) and (Answer <= -10010) then
    begin
      case Answer of
        -10010: ItemType := Ord(t_Engine);
        -10011: ItemType := Ord(t_DefGenerator);
      else ItemType := Ord(t_Weapon1);
      end;
      if Answer = -10010 then TechLevel := Planet.InventionLevels[2]
      else TechLevel := Planet.InventionLevels[7];
      Prototype := False;
      if (ScienceLevel > 0) and (TechLevel < 8) then
      begin
        case ScienceLevel of
          1: Prototype := NextRandomUnitFloat(Planet.RandomState) < 0.08;
          2: Prototype := NextRandomUnitFloat(Planet.RandomState) < 0.15;
        else Prototype := NextRandomUnitFloat(Planet.RandomState) < 0.25;
        end;
        if Prototype then Inc(TechLevel);
      end;
      Owner := Planet.OwnerId;
      if Answer = -10010 then
      begin
        Item := TEngine.Create;
        TEngine(Item).Init(Round(EngineBaseSize), TechLevel, Owner);
      end
      else if Answer = -10011 then
      begin
        Item := TDefGenerator.Create;
        TDefGenerator(Item).Init(Round(DefGeneratorBaseSize), TechLevel, Owner);
      end
      else
      begin
        Item := Planet.GenerateEquipmentOffer(GetPlayer, ItemType);
        if Item <> nil then
          TWeapon(Item).Init(TWeapon(Item).ItemType, TWeapon(Item).Weight, TechLevel, TWeapon(Item).OwnerId);
      end;
      if Item = nil then
      begin
        Inc(Planet.Money, Cost);
        DialogText := 'Планета пока не может изготовить этот тип оборудования. Средства возвращены в бюджет.';
      end
      else
      begin
        Planet.EquipmentShop.Add(Item);
        if Prototype then
          DialogText := 'Изготовлен экспериментальный прототип уровня L' + IntToStr(TechLevel) + ' и добавлен в магазин планеты.'
        else
          DialogText := 'Оборудование уровня L' + IntToStr(TechLevel) + ' изготовлено и добавлено в магазин планеты.';
      end;
    end
    else if Answer = -10015 then
    begin
      if Planet.InventionLevels[2] >= 8 then
      begin
        Inc(Planet.Money, Cost);
        DialogText := 'Технология двигателей уже достигла максимального уровня L8. Средства возвращены.';
      end
      else
      begin
        Inc(Planet.InventionLevels[2]);
        DialogText := 'Технология двигателей повышена до L' + IntToStr(Planet.InventionLevels[2]) + '.';
      end;
    end
    else if Answer = -10016 then
    begin
      if Planet.InventionLevels[7] >= 8 then
      begin
        Inc(Planet.Money, Cost);
        DialogText := 'Главная технология уже достигла максимального уровня L8. Средства возвращены.';
      end
      else
      begin
        Inc(Planet.InventionLevels[7]);
        DialogText := 'Технологии защиты и оружия повышены до L' + IntToStr(Planet.InventionLevels[7]) + '.';
      end;
    end
    else if Answer = -10020 then
    begin
      DialogText := 'Конструктор гарнизонного корабля. Оснащение будет создано строго по текущим технологиям планеты.';
      ClearDialogChoices;
      AddChoice('Лёгкий перехватчик: двигатель + оружие (15000 cr.)', -10021, RunInjectedAnswer);
      AddChoice('Защитник: двигатель + щит + оружие (30000 cr.)', -10022, RunInjectedAnswer);
      AddChoice('Назад', -10000, RunInjectedAnswer);
      Exit;
    end
    else if (Answer = -10021) or (Answer = -10022) then
    begin
      Ship := TShip(Planet.BuyWarrior(100));
      for I := Ship.Inventory.Count - 1 downto 1 do Ship.Inventory.Delete(I);
      Ship.RebuildEquipmentCache;
      Ship.CreateAndEquipFuelTanks(Round(FuelTanksBaseSize), 1, Ship.OwnerId);
      Ship.CreateAndEquipEngine(Round(EngineBaseSize), Planet.InventionLevels[2], Ship.OwnerId);
      if Answer = -10022 then
        Ship.CreateAndEquipDefGenerator(Round(DefGeneratorBaseSize), Planet.InventionLevels[7], Ship.OwnerId);
      Ship.CreateAndEquipWeapon(Ord(t_Weapon1), Round(WeaponInfos[Ord(t_Weapon1)].AverageSize), Planet.InventionLevels[7], Ship.OwnerId);
      Ship.RefreshDerivedStats(True);
      if Answer = -10021 then
        DialogText := 'Построен перехватчик: двигатель L' + IntToStr(Planet.InventionLevels[2]) +
          ' и оружие L' + IntToStr(Planet.InventionLevels[7]) + '.'
      else
        DialogText := 'Построен защитник: двигатель L' + IntToStr(Planet.InventionLevels[2]) +
          ', щит и оружие L' + IntToStr(Planet.InventionLevels[7]) + '.';
    end
    else if Answer = -10099 then
    begin
      BuildGovernmentChoices(True);
      Exit;
    end;
    ClearDialogChoices;
    AddChoice('Продолжить управление', -10000, RunInjectedAnswer);
    AddChoice('Назад к правительству', -10099, RunInjectedAnswer);
    Exit;
  end;
  Injection := PScriptDialogInjection(Answer);
  if Injection.ActionCode <> '' then
  begin
    CurrentScript := Injection.ActionScript;
    ExecuteScriptText(Injection.ActionCode, CurrentScript.InitCode.LocalVar);
  end;
  Text := Injection.Answer;
  PartCount := CountDelimitedPartsW(Text, '~');
  if PartCount > 1 then
  begin
    Text := ExtractDelimitedPartW(WideString(LowerCase(AnsiString(Text))), 0, '~');
    if Text = 'snap' then RememberChoiceScroll;
  end;
  ClearDialogChoices;
  CurrentScript := Injection.Script;
  CurrentScript.InitCode.LocalVar.GetVar('GAnswerData').SetDword(Injection.AnswerData);
  ScriptDialogIndex := -1;
  CurrentScript.CallDialogByVariable(Injection.DialogName);
  if ScriptDialogIndex < 0 then BuildGovernmentChoices(True)
  else CurrentScript.CallDialogMessage(ScriptDialogIndex);
end;
{ @end $52DB2C }

{ @routine $52DCF0 TfGov_RunInjectedAnswerKeepingScroll }
procedure TfGov.RunInjectedAnswerKeepingScroll(Answer: Integer);
begin
  RememberChoiceScroll;
  RunInjectedAnswer(Answer);
end;
{ @end $52DCF0 }

{ @routine $52DD14 TfGov_RunScriptRestartAnswer }
procedure TfGov.RunScriptRestartAnswer(Answer: Integer);
begin
  DialogText := '';
  CurrentScript.ExecuteDialogAnswer(Answer);
  RefreshGovernmentDialog;
end;
{ @end $52DD14 }

{ @routine $52DD48 TfGov_AddScriptRestartChoice }
procedure TfGov.AddScriptRestartChoice(Caption: WideString);
begin
  AddChoice('- ' + Caption, CurrentScript.CurrentAnswer, RunScriptRestartAnswer);
end;
{ @end $52DD48 }

{ @routine $52DDD0 TfGov_ExecuteUiCode }
procedure TfGov.ExecuteUiCode(Block: TBlockParEC; Key: Cardinal);
begin
  if MainPanel.NavigationLocked then Exit;
  if ExitScreenLoop then Exit;
  if TurnCalculationPhase in [tcpIdle, tcpGalaxyFinished, tcpPlayerStarFinished, tcpPlayerStarPrepared] then
  begin
    Galaxy.CheckIntegrityChecksum(10008);
    ExecuteGameplayUiCode(Block, Key);
    Galaxy.PrimeIntegrityChecksum(20008);
  end;
end;
{ @end $52DDD0 }

end.
