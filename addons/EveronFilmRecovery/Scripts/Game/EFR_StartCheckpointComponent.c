[ComponentEditorProps(category: "Film Recovery", description: "Pause and save the recovered starting layout")]
class EFR_StartCheckpointComponentClass : ScriptComponentClass
{
}

class EFR_StartCheckpointComponent : ScriptComponent
{
 protected int m_Attempts;

 override void OnPostInit(IEntity owner)
 {
  if (SCR_Global.IsEditMode(owner))
   return;
  GetGame().GetCallqueue().CallLater(PrepareCheckpoint, 100, true);
 }

 protected void PrepareCheckpoint()
 {
  m_Attempts++;
  SaveGameManager manager = GetGame().GetSaveGameManager();
  SCR_BaseGameMode mode = SCR_BaseGameMode.Cast(GetGame().GetGameMode());
  if (!manager || !mode)
   return;

  manager.SetEnabledSaveTypes(ESaveGameType.MANUAL | ESaveGameType.AUTO);
  if (!manager.IsSavingAllowed())
  {
   if (m_Attempts >= 200)
   {
    GetGame().GetCallqueue().Remove(PrepareCheckpoint);
    Print("[EveronFilmRecovery] CHECKPOINT_BLOCKED saving not available");
   }
   return;
  }

  GetGame().GetCallqueue().Remove(PrepareCheckpoint);
  mode.PauseGame(true, SCR_EPauseReason.EDITOR);
  int found;
  for (int i = 1; i <= 27; i++)
  {
   string suffix = i.ToString();
   if (i < 10)
    suffix = "0" + suffix;
   IEntity entity = GetGame().GetWorld().FindEntityByName("Film_Entity_" + suffix);
   if (entity)
   {
    found++;
    PrintFormat("[EveronFilmRecovery] ENTITY %1 position=%2", entity.GetName(), entity.GetOrigin());
   }
  }
  PrintFormat("[EveronFilmRecovery] ENTITY_COUNT %1/27", found);
  if (found != 27)
  {
   Print("[EveronFilmRecovery] CHECKPOINT_BLOCKED incomplete entity reconstruction");
   return;
  }
  if (manager.GetActiveSave())
  {
   Print("[EveronFilmRecovery] LOADED_CHECKPOINT retained and paused");
   return;
  }
  Print("[EveronFilmRecovery] CHECKPOINT_REQUEST Everon NATO Film Start - Recovered 2026-10-08");
  manager.RequestSavePoint(ESaveGameType.MANUAL, "Everon NATO Film Start - Recovered 2026-10-08", ESaveGameRequestFlags.BLOCKING, new SaveGameOperationCallback(OnCheckpointSaved));
 }

 protected void OnCheckpointSaved(bool success)
 {
  if (success)
   Print("[EveronFilmRecovery] CHECKPOINT_SUCCESS");
  else
   Print("[EveronFilmRecovery] CHECKPOINT_FAILED");
 }
}
