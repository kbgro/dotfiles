import St from 'gi://St';
import Clutter from 'gi://Clutter';

export class TimerCard {
    constructor(timer, store) {
        this._timer = timer;
        this._store = store;

        this._build();
        this.update();
    }

    _build() {
        this._container = new St.BoxLayout({
            style_class: 'timer-card',
            x_expand: true,
        });

        // Timer icon
        this._icon = new St.Icon({
            icon_name: 'alarm-symbolic',
            style_class: 'timer-card-icon',
        });

        // Time
        this._timeLabel = new St.Label({
            text: '0s',
            style_class: 'timer-card-time',
            x_expand: true,
            y_align: Clutter.ActorAlign.CENTER,
        });

        // ─────────────────────────────────────────
        // Lap button
        // ─────────────────────────────────────────

        this._lapButton = new St.Button({
            style_class: 'timer-card-lap-button',
            can_focus: true,
        });

        const lapBox = new St.BoxLayout({
            style_class: 'timer-card-lap-box',
        });

        const lapIcon = new St.Icon({
            icon_name: 'list-add-symbolic',
            icon_size: 12,
            style_class: 'timer-card-lap-icon',
        });

        const lapLabel = new St.Label({
            text: ' lap',
            style_class: 'timer-card-lap-label',
            y_align: Clutter.ActorAlign.CENTER,
        });

        lapBox.add_child(lapIcon);
        lapBox.add_child(lapLabel);

        this._lapButton.set_child(lapBox);
        this._lapButton.set_accessible_name('Add lap');

        this._lapButton.connect('clicked', () => {
            this._timer.addLap();
            this._store.update(this._timer);
            this.update();
        });

        // ─────────────────────────────────────────
        // Pause / Resume button
        // ─────────────────────────────────────────

        this._pauseButton = new St.Button({
            style_class: 'timer-card-action-button',
            can_focus: true,
        });

        this._pauseIcon = new St.Icon({
            icon_name: 'media-playback-pause-symbolic',
            icon_size: 16,
            style_class: 'timer-card-action-icon',
        });

        this._pauseButton.set_child(this._pauseIcon);

        this._pauseButton.connect('clicked', () => {
            if (this._timer.status === 'running') {
                this._timer.pause();
            } else if (this._timer.status === 'paused') {
                this._timer.start();
            }

            this._store.update(this._timer);
            this.update();
        });

        // ─────────────────────────────────────────
        // Stop button
        // ─────────────────────────────────────────

        this._stopButton = new St.Button({
            style_class: 'timer-card-action-button',
            can_focus: true,
        });

        const stopIcon = new St.Icon({
            icon_name: 'media-playback-stop-symbolic',
            icon_size: 16,
            style_class: 'timer-card-action-icon',
        });

        this._stopButton.set_child(stopIcon);
        this._stopButton.set_accessible_name('Stop stopwatch');

        this._stopButton.connect('clicked', () => {
            this._timer.finish();

            this._store.update(this._timer);
            this.update();
        });

        // ─────────────────────────────────────────
        // Edit button
        // ─────────────────────────────────────────

        this._editButton = new St.Button({
            style_class: 'timer-card-edit-button',
            can_focus: true,
        });

        const editIcon = new St.Icon({
            icon_name: 'document-edit-symbolic',
            icon_size: 16,
            style_class: 'timer-card-edit-icon',
        });

        this._editButton.set_child(editIcon);
        this._editButton.set_accessible_name('Edit timer');

        this._editButton.connect('clicked', () => {
            console.log('Edit timer');
        });

// ─────────────────────────────────────────
// Delete button
// ─────────────────────────────────────────

this._deleteButton = new St.Button({
    style_class: 'timer-card-delete-button',
    can_focus: true,
    visible: false,
});

const delIcon = new St.Icon({
    icon_name: 'edit-delete-symbolic',
    icon_size: 16,
    style_class: 'timer-card-delete-icon',
});

this._deleteButton.set_child(delIcon);
this._deleteButton.set_accessible_name('Delete timer');

this._deleteButton.connect('clicked', () => {
    this._store.remove(this._timer);
});

// ─────────────────────────────────────────
// Layout
// ─────────────────────────────────────────

this._container.add_child(this._icon);
this._container.add_child(this._timeLabel);
this._container.add_child(this._lapButton);
this._container.add_child(this._pauseButton);
this._container.add_child(this._stopButton);
this._container.add_child(this._editButton);
this._container.add_child(this._deleteButton);
    }

    update() {
        this._timeLabel.text =
            this._formatTime(this._timer.elapsed);

        this._updatePauseButton();
        this._updateActions();
    }

    _updatePauseButton() {
        if (this._timer.status === 'paused') {
            this._pauseIcon.icon_name =
                'media-playback-start-symbolic';

            this._pauseButton.set_accessible_name(
                'Resume stopwatch'
            );

            return;
        }

        this._pauseIcon.icon_name =
            'media-playback-pause-symbolic';

        this._pauseButton.set_accessible_name(
            'Pause stopwatch'
        );
    }

    _updateActions() {
        const isRunning =
            this._timer.status === 'running';

        const isPaused =
            this._timer.status === 'paused';

        const isFinished =
            this._timer.status === 'finished';

        // Lap only while running.
        this._lapButton.visible = isRunning;

        // Pause/Resume and Stop while running or paused.
        this._pauseButton.visible =
            isRunning || isPaused;

        this._stopButton.visible =
            isRunning || isPaused;

        // Edit is always available.
        this._editButton.visible = true;

        // Delete only when finished.
        this._deleteButton.visible = isFinished;
    }

    _formatTime(milliseconds) {
        const seconds = Math.floor(milliseconds / 1000);

        const hours = Math.floor(seconds / 3600);
        const minutes = Math.floor((seconds % 3600) / 60);
        const remainingSeconds = seconds % 60;

        let result = '';
        if (hours > 0) {
            result += `${hours}h `;
        }
        result += `${minutes}m ${remainingSeconds}s`;

        return result;
    }

    get actor() {
        return this._container;
    }

    destroy() {
        this._lapButton?.destroy();
        this._pauseButton?.destroy();
        this._stopButton?.destroy();
        this._editButton?.destroy();
        this._deleteButton?.destroy();

        this._icon?.destroy();
        this._pauseIcon?.destroy();
        this._timeLabel?.destroy();
        this._container?.destroy();

        this._lapButton = null;
        this._pauseButton = null;
        this._stopButton = null;
        this._editButton = null;
        this._deleteButton = null;

        this._icon = null;
        this._pauseIcon = null;
        this._timeLabel = null;
        this._container = null;

        this._timer = null;
        this._store = null;
    }
}
