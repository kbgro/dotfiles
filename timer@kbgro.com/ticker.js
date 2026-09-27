import GLib from 'gi://GLib';

export class Ticker {
    constructor(interval = 1000) {
        this._interval = interval;
        this._sourceId = null;
        this._listeners = [];
    }

    start() {
        if (this._sourceId !== null)
            return;

        this._sourceId = GLib.timeout_add(
            GLib.PRIORITY_DEFAULT,
            this._interval,
            () => {
                this._tick();
                return GLib.SOURCE_CONTINUE;
            }
        );
    }

    stop() {
        if (this._sourceId === null)
            return;

        GLib.Source.remove(this._sourceId);
        this._sourceId = null;
    }

    _tick() {
        this._listeners.forEach(callback => {
            callback();
        });
    }

    addListener(callback) {
        this._listeners.push(callback);

        return () => {
            this.removeListener(callback);
        };
    }

    removeListener(callback) {
        this._listeners = this._listeners.filter(
            listener => listener !== callback
        );
    }

    destroy() {
        this.stop();
        this._listeners = [];
    }
}
