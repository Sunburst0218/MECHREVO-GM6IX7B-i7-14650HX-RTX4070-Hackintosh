#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")"
if [ "$(uname -s)" != Darwin ]; then
  echo 'This preparation script requires macOS. See INSTALL.md for manual preparation.' >&2
  exit 1
fi
target="$PWD/EFI/OC/Kexts/SimpleHDA.kext"
if [ ! -d "$PWD/EFI/OC/Kexts" ]; then
  echo 'Download and extract the EFI release ZIP first; run the copy of this script inside that folder.' >&2
  exit 1
fi
if [ -e "$target" ]; then
  echo 'SimpleHDA.kext already exists. No existing files were replaced.'
  exit 0
fi
stage="$(mktemp -d "${TMPDIR:-/tmp}/GM6IX7B-SimpleHDA.XXXXXX")"
url='https://github.com/laobamac/SimpleHDA/releases/download/v1.0.0/SimpleHDA-Tahoe-v1.0.0-RELEASE.zip'
expected='89198256664078c91155d673ee7cebb08134dad1b71d5e34b0aa4ef0d4877f8f'
echo 'Downloading the original SimpleHDA 1.0.0 RELEASE package from the author...'
/usr/bin/curl --fail --location --proto '=https' --tlsv1.2 --retry 2 "$url" -o "$stage/SimpleHDA.zip"
actual="$(/usr/bin/shasum -a 256 "$stage/SimpleHDA.zip" | /usr/bin/awk '{print $1}')"
if [ "$actual" != "$expected" ]; then
  echo "SHA-256 mismatch. Stopped without changing EFI. Download retained at $stage" >&2
  exit 1
fi
/usr/bin/ditto -x -k "$stage/SimpleHDA.zip" "$stage/unpacked"
payload="$stage/unpacked/SimpleHDA-Tahoe-v1.0.0-RELEASE/SimpleHDA.kext"
if [ ! -f "$payload/Contents/MacOS/SimpleHDA" ]; then
  echo "Unexpected upstream archive layout. Stopped. Files retained at $stage" >&2
  exit 1
fi
bin_sha="$(/usr/bin/shasum -a 256 "$payload/Contents/MacOS/SimpleHDA" | /usr/bin/awk '{print $1}')"
if [ "$bin_sha" != 'f74c9dbddf43266c97c5f72cd76498bce1d6b5bd3731a947be62f1378b4c7954' ]; then
  echo 'Upstream binary hash mismatch. Stopped.' >&2
  exit 1
fi
/usr/bin/ditto "$payload" "$target"
echo 'SimpleHDA copied into this extracted EFI folder only.'
echo 'Next: generate your OWN SMBIOS identity, fill config.template.plist, save as config.plist, and validate it.'
echo "Original upstream package retained at: $stage"
echo 'No system extensions were installed and no EFI partition was mounted or modified.'
