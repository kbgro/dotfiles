export class Timer {
    constructor({
        id,
        name,
        icon,
        type = 'timer',
        duration = null,
        endTime = null,
        startTime = null,
        elapsed = 0,
        status = 'idle',
        laps = [],
        notes = '',
    }) {
        this.id = id;
        this.name = name;
        this.icon = icon;

        // 'timer' | 'stopwatch'
        this.type = type;

        // Timer duration in milliseconds
        this.duration = duration;

        // Timestamp when the timer should finish
        this.endTime = endTime;

        // Timestamp when the current run started
        this.startTime = startTime;

        // Elapsed time accumulated before the current run
        this._elapsed = elapsed;

        // idle | running | paused | finished
        this.status = status;

        // Stopwatch only
        this.laps = laps;

        this.notes = notes;
    }

    // ─────────────────────────────────────────────
    // Type
    // ─────────────────────────────────────────────

    get isTimer() {
        return this.type === 'timer';
    }

    get isStopwatch() {
        return this.type === 'stopwatch';
    }

    // ─────────────────────────────────────────────
    // Time
    // ─────────────────────────────────────────────

    get elapsed() {
        if (this.status !== 'running')
            return this._elapsed;

        if (!this.startTime)
            return this._elapsed;

        const now = Date.now();

        if (this.isTimer) {
            return Math.min(
                this.duration,
                this._elapsed + (now - this.startTime)
            );
        }

        return this._elapsed + (now - this.startTime);
    }

    get remaining() {
        if (!this.isTimer)
            return null;

        return Math.max(
            0,
            this.duration - this.elapsed
        );
    }

    get progress() {
        if (!this.isTimer || !this.duration)
            return null;

        return Math.min(
            1,
            this.elapsed / this.duration
        );
    }

    // ─────────────────────────────────────────────
    // State
    // ─────────────────────────────────────────────

    start() {
        if (this.status === 'running')
            return;

        if (this.status === 'finished')
            return;

        this.startTime = Date.now();
        this.status = 'running';

        if (this.isTimer && this.endTime === null) {
            this.endTime =
                this.startTime +
                (this.duration - this._elapsed);
        }
    }

    pause() {
        if (this.status !== 'running')
            return;

        this._elapsed = this.elapsed;
        this.startTime = null;

        this.status = 'paused';
    }

    reset() {
        this._elapsed = 0;
        this.startTime = null;

        if (this.isTimer) {
            this.endTime = null;
        }

        this.status = 'idle';

        if (this.isStopwatch) {
            this.laps = [];
        }
    }

    finish() {
        if (this.isTimer) {
            this._elapsed = this.duration;
            this.endTime = null;
        } else {
            this._elapsed = this.elapsed;
        }

        this.startTime = null;
        this.status = 'finished';
    }

    // ─────────────────────────────────────────────
    // Stopwatch
    // ─────────────────────────────────────────────

    addLap() {
        if (!this.isStopwatch) {
            throw new Error(
                'Laps are only supported by stopwatches'
            );
        }

        this.laps.push({
            number: this.laps.length + 1,
            elapsed: this.elapsed,
        });
    }

    // ─────────────────────────────────────────────
    // Persistence
    // ─────────────────────────────────────────────

     toJSON() {
         return {
             id: this.id,
             name: this.name,
             icon: this.icon,
             type: this.type,

             duration: this.duration,
             endTime: this.endTime,
             startTime: this.startTime,

             elapsed: this._elapsed,
             status: this.status,

             laps: this.laps,
             notes: this.notes,
         };
     }
}
