# Image assets

`AppIcon/source.png` was created for this app using the built-in image_gen tool
on 2026-10-10. The prompt requested an opaque navy square, a diagonal stylized
minimap with cyan map paths and a red location signal, without text or an existing
game logo. The full prompt is retained in `AppIcon/prompt.txt`. The original is
kept intact; ImageMagick converts only its dimensions and PNG color format for
the iPhone and iPad Home Screen sizes. The bundle contains the small icon PNGs;
the source artwork and prompt remain in the source archive.

`Heroes` contains unmodified public champion portraits from the official Tencent
Wild Rift champion directory:
https://lolm.qq.com/v2/champions.html
https://game.gtimg.cn/images/lgamem/act/lrlib/js/heroList/hero_list.js

Champion portraits and characters belong to their respective rights holders,
Riot Games / Tencent. They are third-party image assets, not original recovered
source code. The raw public directory snapshot is retained in
`analysis/official-hero-list.json`; its hash, retrieval time, exact native hero
IDs, image URLs and hashes are recorded in `Heroes/manifest.json`.
No game executables, SDK files or private device screenshots are included here.

The HUD maps native actor `resource_id` to the directory's exact `heroId`.
Matching does not use roster order or ID arithmetic. All images are bundled,
and no image download occurs while the overlay is running. Unknown IDs or
unreadable images fall back to the existing numeric marker. The circular crop
and red border are drawn at runtime using UIKit; the supplied images are intact.
