var state = {};

function onControlsInitialized() {
    ASPxClientEdit.AttachEditorModificationListener(onEditorsChanged, function (control) {
        var templateOfControls = control.GetParentControl();
        var parrentControl = (templateOfControls) ? templateOfControls.GetParentControl() : {};
        return parrentControl === grid
    });
    state = ASPxClientUtils.GetEditorValuesInContainer(grid.GetMainElement());
}

function onEditorsChanged(s, e) {
    SetControlsEnabled(true);
}

function onSaveChanges(s, e) {
    grid.UpdateEdit();
}

function onClearChanges(s, e) {
    restoreEditorsState();
    SetControlsEnabled(false);
}

function onCancelEdit(s, e) {
    grid.CancelEdit();
}

function restoreEditorsState() {
    for (var controlName in state) {
        var trackedControl = ASPxClientControl.GetControlCollection().Get(controlName);
        var setValueMethod = trackedControl.SetTokenCollection || trackedControl.SelectValues || trackedControl.SetValue;
        if (setValueMethod === trackedControl.SelectValues)
            trackedControl.UnselectAll();
        setValueMethod.call(trackedControl, state[controlName]);
    }
}

function SetControlsEnabled(enabled) {
    saveBtn.SetEnabled(enabled);
    clearBtn.SetEnabled(enabled);
}