export function getRandomIcon(): string {
    const iconsPull = [
        'pixel-analytics',
        'pixel-blocks',
        'pixel-case',
        'pixel-checkmark',
        'pixel-headset',
        'pixel-lamp',
        'pixel-people',
        'pixel-signal',
        'pixel-track',
        'pixel-wallet',
        'pixel-zap',
    ];

    const randomIcon = iconsPull[Math.floor(Math.random() * iconsPull.length)];

    return randomIcon ?? '';
}
