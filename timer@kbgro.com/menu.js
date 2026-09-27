import St from 'gi://St';
import Clutter from 'gi://Clutter';
import * as PopupMenu from 'resource:///org/gnome/shell/ui/popupMenu.js';

import {TimerCard} from './timerCard.js';
import {Ticker} from './ticker.js';

export class TimerMenu {
    constructor(menu, store, ticker = null) {
        this._menu = menu;
        this._store = store;
        this._cards = [];
        this._ownTicker = !ticker;
        this._ticker = ticker || new Ticker(1000);

        this._build();
        this._addPersistedEntries();
        this._store.addListener(() => this._onStoreChanged());
        this._startClock();
    }

    _build() {
        this._header();

        this._entriesBox = new St.BoxLayout({
            vertical: true,
            style_class: 'timer-menu-entries',
            x_expand: true,
        });

        const entriesItem = new PopupMenu.PopupBaseMenuItem({
            reactive: false,
            can_focus: false,
        });

        entriesItem.add_child(this._entriesBox);

        this._menu.addMenuItem(entriesItem);
    }

    _header() {
        const item = new PopupMenu.PopupBaseMenuItem({
            reactive: false,
            can_focus: false,
        });

        const box = new St.BoxLayout({
            style_class: 'timer-menu-header',
            x_expand: true,
        });

        const title = new St.Label({
            text: 'Timers',
            style_class: 'timer-menu-title',
            x_expand: true,
            y_align: Clutter.ActorAlign.CENTER,
        });

        this._startButton = new St.Button({
            style_class: 'timer-menu-start-button',
            can_focus: true,
            reactive: true,
        });

        const icon = new St.Icon({
            icon_name: 'media-playback-start-symbolic',
            style_class: 'timer-menu-start-icon',
            icon_size: 16,
        });

        this._startButton.set_child(icon);

        this._startButton.set_accessible_name(
            'Start stopwatch'
        );

        this._startButton.connect('clicked', () => {
            this._startStopwatch();
        });

        box.add_child(title);
        box.add_child(this._startButton);

        item.add_child(box);

        this._menu.addMenuItem(item);
    }

    _startClock() {
        this._ticker.start();
        this._ticker.addListener(() => {
            this._cards.forEach(card => {
                card.update();
            });
        });
    }

    _onStoreChanged() {
        const storeIds = new Set(
            this._store.entries.map(t => t.id)
        );

        this._cards = this._cards.filter(card => {
            if (storeIds.has(card._timer.id)) {
                return true;
            }

            card.destroy();
            return false;
        });
    }

    _addPersistedEntries() {
        for (const timer of this._store.entries) {
            const card = new TimerCard(timer, this._store);
            this._cards.push(card);
            this._entriesBox.add_child(card.actor);
        }
    }

    _startStopwatch() {
        const timer = this._store.add({
            id: `${Date.now()}`,
            name: '',
            icon: 'alarm-symbolic',
            type: 'stopwatch',
            notes: '',
        });

        timer.start();

        const card = new TimerCard(timer, this._store);

        this._cards.push(card);
        this._entriesBox.add_child(card.actor);
    }

    destroy() {
        if (this._ownTicker) {
            this._ticker?.destroy();
        }
        this._ticker = null;

        this._cards.forEach(card => card.destroy());
        this._cards = [];

        this._startButton?.destroy();

        this._menu = null;
        this._store = null;
    }
}
