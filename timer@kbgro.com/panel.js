import St from 'gi://St';
import Clutter from 'gi://Clutter';
import * as PanelMenu from 'resource:///org/gnome/shell/ui/panelMenu.js';

import {TimerMenu} from './menu.js';
import {Ticker} from './ticker.js';

export class PanelButton {
    constructor(store, ticker) {
        this._store = store;
        this._ticker = ticker;

        this._button = new PanelMenu.Button(
            0.0,
            'Timer Extension'
        );

        this._box = new St.BoxLayout({
            style_class: 'timer-panel-box',
            y_align: Clutter.ActorAlign.CENTER,
        });

        this._icon = new St.Icon({
            icon_name: 'alarm-symbolic',
            style_class: 'system-status-icon',
        });

        this._box.add_child(this._icon);
        this._button.add_child(this._box);

        this._button.set_accessible_name('Timer');
        this._button.tooltip_text = 'Timer Extension';

        this._menu = new TimerMenu(
            this._button.menu,
            store,
            ticker
        );

        this._store.addListener(() => this.update());
        this._ticker.addListener(() => this.update());

        this.update();
    }

    update() {
        const children = this._box.get_children();
        for (let i = children.length - 1; i >= 0; i--) {
            if (children[i] !== this._icon) {
                this._box.remove_child(children[i]);
            }
        }

        const timers = this._store.entries
            .filter(timer =>
                timer.status === 'running' ||
                timer.status === 'paused'
            );

        const visibleTimers = timers.slice(0, 2);

        for (const timer of visibleTimers) {
            const label = new St.Label({
                text: this._formatTime(timer.elapsed),
                style_class: timer.status === 'paused'
                    ? 'timer-panel-paused'
                    : 'timer-panel-live',
                y_align: Clutter.ActorAlign.CENTER,
            });

            this._box.add_child(label);
        }

        const remaining = timers.length - visibleTimers.length;

        if (remaining > 0) {
            const more = new St.Label({
                text: `+${remaining}`,
                style_class: 'timer-panel-more',
                y_align: Clutter.ActorAlign.CENTER,
            });

            this._box.add_child(more);
        }
    }

    _formatTime(milliseconds) {
        const seconds = Math.floor(milliseconds / 1000);

        const hours = Math.floor(seconds / 3600);
        const minutes = Math.floor((seconds % 3600) / 60);
        const remainingSeconds = seconds % 60;

        return `${hours}:${String(minutes).padStart(2, '0')}:${String(
            remainingSeconds
        ).padStart(2, '0')}`;
    }

    get actor() {
        return this._button;
    }

    destroy() {
        this._menu?.destroy();
        this._button?.destroy();

        this._menu = null;
        this._button = null;
        this._box = null;
        this._icon = null;
        this._store = null;
        this._ticker = null;
    }
}
