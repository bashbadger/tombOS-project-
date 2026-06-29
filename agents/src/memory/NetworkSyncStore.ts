import * as fs from 'fs';
import * as path from 'path';

export interface QueuedAlert {
  id: string;
  platform: string;
  payload: any;
  timestamp: number;
}

export class NetworkSyncStore {
  private outboxPath: string;

  constructor() {
    this.outboxPath = path.join(process.cwd(), 'data', 'local_outbox.json');
    this.ensureDirectoryExists();
  }

  private ensureDirectoryExists() {
    const dir = path.dirname(this.outboxPath);
    if (!fs.existsSync(dir)) {
      fs.mkdirSync(dir, { recursive: true });
    }
    if (!fs.existsSync(this.outboxPath)) {
      fs.writeFileSync(this.outboxPath, JSON.stringify([]), 'utf8');
    }
  }

  public queueAlert(platform: string, payload: any): void {
    const outbox = this.readOutbox();
    const alert: QueuedAlert = {
      id: Math.random().toString(36).substring(2, 9),
      platform,
      payload,
      timestamp: Date.now()
    };
    outbox.push(alert);
    this.writeOutbox(outbox);
    console.log(`[OFFLINE CACHE] Queued alert locally. Network offline. Saved to ${this.outboxPath}`);
  }

  public readOutbox(): QueuedAlert[] {
    try {
      const data = fs.readFileSync(this.outboxPath, 'utf8');
      return JSON.parse(data);
    } catch {
      return [];
    }
  }

  private writeOutbox(outbox: QueuedAlert[]): void {
    fs.writeFileSync(this.outboxPath, JSON.stringify(outbox, null, 2), 'utf8');
  }

  public async syncOutbox(sendCallback: (alert: QueuedAlert) => Promise<boolean>): Promise<void> {
    let outbox = this.readOutbox();
    if (outbox.length === 0) return;

    console.log(`[ONLINE SYNC] Network connection active. Syncing ${outbox.length} cached alerts...`);
    const remaining: QueuedAlert[] = [];

    for (const alert of outbox) {
      try {
        const success = await sendCallback(alert);
        if (!success) {
          remaining.push(alert);
        }
      } catch {
        remaining.push(alert);
      }
    }

    this.writeOutbox(remaining);
    console.log(`[ONLINE SYNC] Sync complete. ${outbox.length - remaining.length} alerts flushed.`);
  }
}
