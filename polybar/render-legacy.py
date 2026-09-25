#!/usr/bin/env python3
"""Adapt the shared Polybar layout for Polybar releases before 3.7."""

from pathlib import Path
import re
import sys
import os


def render(config: str) -> str:
    sections = re.split(r"(?=^\[[^\]]+\])", config, flags=re.MULTILINE)
    result = []
    interfaces = {
        "wlan": os.environ.get("POLYBAR_WLAN_INTERFACE", ""),
        "eth": os.environ.get("POLYBAR_ETH_INTERFACE", ""),
    }
    removed = {"systray"} | {name for name, interface in interfaces.items() if not interface}
    for section in sections:
        heading = re.match(r"^\[([^\]]+)\]", section)
        name = heading.group(1) if heading else ""
        if name.startswith("module/") and name.removeprefix("module/") in removed:
            continue

        if name.startswith("bar/"):
            bar_removed = removed | ({"edge-right"} if name == "bar/time_s1" else set())
            section = re.sub(
                r"^(modules-right\s*=\s*)(.*)$",
                lambda match: match.group(1)
                + " ".join(item for item in match.group(2).split() if item not in bar_removed),
                section,
                flags=re.MULTILINE,
            )
        if name == "bar/time_s1":
            # The old tray is appended after modules-right, unlike the 3.7
            # tray module. Make the bar slightly narrower and draw its real
            # right border after the tray, preserving the outer screen gap.
            section = re.sub(r"^width\s*=.*$", "width = 98%", section, flags=re.MULTILINE)
            section = re.sub(r"^border-right-size\s*=.*$", "border-right-size = 3px", section, flags=re.MULTILINE)
            section = re.sub(r"^border-right-color\s*=.*$", "border-right-color = ${env:POLYBAR_I3_BORDER}", section, flags=re.MULTILINE)
            section = section.replace("enable-ipc = true", "tray-position = right\nenable-ipc = true", 1)

        if name in {"module/wlan", "module/eth"}:
            interface = interfaces[name.removeprefix("module/")]
            if not re.fullmatch(r"[A-Za-z0-9_.:-]+", interface):
                raise ValueError(f"Invalid network interface: {interface!r}")
            section = re.sub(r"^interface-type\s*=.*$", f"interface = {interface}", section, flags=re.MULTILINE)

        if re.search(r"^type\s*=\s*custom/text\s*$", section, re.MULTILINE):
            section = re.sub(r"^format(-[\w-]+)?(\s*=)", r"content\1\2", section, flags=re.MULTILINE)

        result.append(section)
    return "".join(result)


def main() -> None:
    source, target = map(Path, sys.argv[1:3])
    content = render(source.read_text())
    target.parent.mkdir(parents=True, exist_ok=True)
    if not target.exists() or target.read_text() != content:
        target.write_text(content)


if __name__ == "__main__":
    main()
