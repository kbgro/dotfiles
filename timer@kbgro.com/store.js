import Gio from 'gi://Gio';

import {Timer} from './timer.js';

export class TimersStore {
    constructor(path) {
        this._file = Gio.File.new_for_path(path);

        this._entries = [];
        this._listeners = [];

        this._load();
    }

    // ─────────────────────────────────────────────
    // Persistence
    // ─────────────────────────────────────────────

    _load() {
        try {
            if (!this._file.query_exists(null))
                return;

            const [, contents] = this._file.load_contents(null);

            const json = new TextDecoder().decode(contents);
            const data = JSON.parse(json);

            this._entries = data.map(entry =>
                new Timer(entry)
            );
        } catch (error) {
            console.error(
                `Failed to load timers: ${error.message}`
            );

            this._entries = [];
        }
    }

    _save() {
        try {
            const data = this._entries.map(timer =>
                timer.toJSON()
            );

            const json = JSON.stringify(data, null, 2);

            this._file.replace_contents(
                new TextEncoder().encode(json),
                null,
                false,
                Gio.FileCreateFlags.REPLACE_DESTINATION,
                null
            );
        } catch (error) {
            console.error(
                `Failed to save timers: ${error.message}`
            );
        }
    }

    // ─────────────────────────────────────────────
    // Observers
    // ─────────────────────────────────────────────

    emitChanged() {
        this._listeners.forEach(cb => cb());
    }

    addListener(cb) {
        this._listeners.push(cb);

        return () => this.removeListener(cb);
    }

    removeListener(cb) {
        this._listeners = this._listeners.filter(
            listener => listener !== cb
        );
    }

    // ─────────────────────────────────────────────
    // Entries
    // ─────────────────────────────────────────────

    add(options) {
        const timer = new Timer(options);

        this._entries.push(timer);

        this._save();
        this.emitChanged();

        return timer;
    }

    remove(timer) {
        const index = this._entries.indexOf(timer);

        if (index === -1)
            return;

        this._entries.splice(index, 1);

        this._save();
        this.emitChanged();
    }

    update(timer) {
        if (!this._entries.includes(timer))
            return;

        this._save();
        this.emitChanged();
    }

    get entries() {
        return [...this._entries];
    }

    get size() {
        return this._entries.length;
    }

    clear() {
        if (this._entries.length === 0)
            return;

        this._entries = [];

        this._save();
        this.emitChanged();
    }
}
