# User constraints for this project

- Do not compile, run tests, emulate original instructions, or execute validation on the user's current server. Use GitHub-hosted Actions runners for all build and validation work; never select a self-hosted runner. Local file inventory, reading binary headers for inspection, source editing, and Git/GitHub operations are allowed.
- Publish source and build releases in the public `zwthys-cyber/wildrift-recovery` repository. Keep the original national-server repository separate.
- The international application must install alongside the national-server application. Keep `local.wildrift.recovery` and its HUD entitlements, notification namespace and temporary state separate from `local.lvlolm.recovery`. Display name: `Wild Rift 国际服`.
- User target: international Wild Rift 7.3.0 build 2813, iOS 17.0, TrollStore. Original uploaded files are in `/root/wild Rift/` and must be preserved.
- Do not publish plaintext game IPAs, frameworks or complete metadata. CI input transport uses an encrypted release attachment and an Actions Secret; plaintext exists only on the ephemeral runner during CI. Do not include inputs in source archives or tool installation packages.
- GitHub checks are not phone runtime verification. Treat historical CN device reports as upstream evidence only.

- Keep ongoing work read-only: no game-process memory writes, game code injection, camera modification, or automatic touch. The user explicitly asked whether the features modify game memory; preserve the clarified read-only scope.
