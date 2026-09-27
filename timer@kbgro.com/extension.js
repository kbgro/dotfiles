import GLib from 'gi://GLib';

import {Extension} from 'resource:///org/gnome/shell/extensions/extension.js';
import * as Main from 'resource:///org/gnome/shell/ui/main.js';

import {PanelButton} from './panel.js';
import {TimersStore} from './store.js';
import {Ticker} from './ticker.js';

export default class TimerExtension extends Extension {
    enable() {
        const dataDir = GLib.build_filenamev([
            GLib.get_user_data_dir(),
            this.uuid,
        ]);

        GLib.mkdir_with_parents(
            dataDir,
            0o755
        );

        const storePath = GLib.build_filenamev([
            dataDir,
            'timers.json',
        ]);

        this._store = new TimersStore(storePath);

        this._ticker = new Ticker(1000);

        this._button = new PanelButton(
            this._store,
            this._ticker
        );

        Main.panel.addToStatusArea(
            'timer',
            this._button.actor,
            1,
            'right'
        );

        this._ticker.start();
    }

    disable() {
        this._button?.destroy();
        this._button = null;

        this._ticker?.stop();
        this._ticker = null;

        this._store = null;
    }
}
