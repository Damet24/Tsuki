import os
import sys
import json
import hashlib
import tempfile
from pathlib import Path

# load sync script as module (no .py extension)
SCRIPT = Path(__file__).parent.parent / "scripts" / "sync"
_ns = {"__name__": "sync", "__file__": str(SCRIPT)}
exec(compile(SCRIPT.read_bytes(), SCRIPT, "exec"), _ns)

GLOBAL_IGNORE = _ns["GLOBAL_IGNORE"]
is_ignored = _ns["is_ignored"]
is_included = _ns["is_included"]
entry_src = _ns["entry_src"]
entry_hash = _ns["entry_hash"]
load_state = _ns["load_state"]
state_path = _ns["state_path"]
dotctl_dir = _ns["dotctl_dir"]
is_managed_symlink = _ns["is_managed_symlink"]

HOME = Path.home()
REPO = Path("/fake/repo")


def make_profile(ignore=None, include=None, exclude_patterns=None):
    return {
        "include": include or [],
        "ignore": ignore or [],
        "exclude_patterns": exclude_patterns or [],
    }


# =========================
# is_ignored
# =========================

def test_ignores_global_dot_git():
    p = REPO / ".git" / "config"
    assert is_ignored(p, REPO, make_profile())


def test_ignores_global_dot_dotctl():
    p = REPO / ".dotctl" / "state.json"
    assert is_ignored(p, REPO, make_profile())


def test_ignores_global_pycache():
    p = REPO / "scripts" / "__pycache__" / "foo.pyc"
    assert is_ignored(p, REPO, make_profile())


def test_ignores_by_config_ignore():
    profile = make_profile(ignore=["scripts"])
    p = REPO / "scripts" / "sync"
    assert is_ignored(p, REPO, profile)


def test_ignores_by_exclude_pattern():
    profile = make_profile(exclude_patterns=["*.log"])
    p = REPO / "var" / "server.log"
    assert is_ignored(p, REPO, profile)


def test_does_not_ignore_normal_file():
    p = REPO / ".config" / "kitty" / "kitty.conf"
    assert not is_ignored(p, REPO, make_profile())


# =========================
# is_included
# =========================

def test_included_when_no_include_list():
    profile = make_profile(include=[])
    p = REPO / "any" / "file"
    assert is_included(p, REPO, profile)


def test_included_exact_match():
    profile = make_profile(include=[".config"])
    p = REPO / ".config"
    assert is_included(p, REPO, profile)


def test_included_prefix_match():
    profile = make_profile(include=[".config"])
    p = REPO / ".config" / "hypr" / "hyprland.conf"
    assert is_included(p, REPO, profile)


def test_not_included_false_positive():
    profile = make_profile(include=[".config"])
    p = REPO / ".config_backup" / "foo"
    assert not is_included(p, REPO, profile)


def test_not_included_unrelated():
    profile = make_profile(include=[".config"])
    p = REPO / "scripts" / "sync"
    assert not is_included(p, REPO, profile)


# =========================
# entry_src / entry_hash
# =========================

def test_entry_src_string_format():
    assert entry_src("/old/path") == "/old/path"


def test_entry_src_dict_format():
    assert entry_src({"src": "/new/path", "hash": "abc"}) == "/new/path"


def test_entry_hash_string_format():
    assert entry_hash("just a string") is None


def test_entry_hash_dict_format():
    assert entry_hash({"src": "/p", "hash": "abc123"}) == "abc123"


def test_entry_hash_missing():
    assert entry_hash({"src": "/p"}) is None


# =========================
# load_state migration
# =========================

def test_load_state_migrates_old_format():
    with tempfile.TemporaryDirectory() as tmp:
        repo = Path(tmp)
        dotctl_dir(repo).mkdir()
        old = {"/home/user/.zshrc": "/home/user/dotfiles/.zshrc"}
        state_path(repo).write_text(json.dumps(old))
        loaded = load_state(repo)
        assert loaded["/home/user/.zshrc"]["src"] == "/home/user/dotfiles/.zshrc"
        assert loaded["/home/user/.zshrc"]["hash"] is None


def test_load_state_preserves_new_format():
    with tempfile.TemporaryDirectory() as tmp:
        repo = Path(tmp)
        dotctl_dir(repo).mkdir()
        data = {"/home/user/.zshrc": {"src": "/repo/.zshrc", "hash": "abc123"}}
        state_path(repo).write_text(json.dumps(data))
        loaded = load_state(repo)
        assert loaded["/home/user/.zshrc"]["src"] == "/repo/.zshrc"
        assert loaded["/home/user/.zshrc"]["hash"] == "abc123"


def test_load_state_empty():
    with tempfile.TemporaryDirectory() as tmp:
        repo = Path(tmp)
        assert load_state(repo) == {}


# =========================
# is_managed_symlink
# =========================

def test_managed_symlink_exists():
    state = {"/home/user/.zshrc": {"src": "/repo/.zshrc", "hash": "abc"}}
    assert is_managed_symlink(Path("/home/user/.zshrc"), state)


def test_managed_symlink_not_exists():
    state = {}
    assert not is_managed_symlink(Path("/home/user/.zshrc"), state)


# =========================
# run
# =========================

def run():
    tests = [
        ("ignores .git", test_ignores_global_dot_git),
        ("ignores .dotctl", test_ignores_global_dot_dotctl),
        ("ignores __pycache__", test_ignores_global_pycache),
        ("ignores by config ignore", test_ignores_by_config_ignore),
        ("ignores by exclude pattern", test_ignores_by_exclude_pattern),
        ("does not skip normal files", test_does_not_ignore_normal_file),
        ("included when no include list", test_included_when_no_include_list),
        ("included exact match", test_included_exact_match),
        ("included prefix match", test_included_prefix_match),
        ("not included false positive (.config != .config_backup)", test_not_included_false_positive),
        ("not included unrelated", test_not_included_unrelated),
        ("entry_src string format", test_entry_src_string_format),
        ("entry_src dict format", test_entry_src_dict_format),
        ("entry_hash string format", test_entry_hash_string_format),
        ("entry_hash dict format", test_entry_hash_dict_format),
        ("entry_hash missing key", test_entry_hash_missing),
        ("load_state migrates old format", test_load_state_migrates_old_format),
        ("load_state preserves new format", test_load_state_preserves_new_format),
        ("load_state empty", test_load_state_empty),
        ("managed symlink exists", test_managed_symlink_exists),
        ("managed symlink not exists", test_managed_symlink_not_exists),
    ]

    passed = 0
    failed = 0

    for name, fn in tests:
        try:
            fn()
            print(f"  ✓ {name}")
            passed += 1
        except Exception as e:
            print(f"  ✗ {name}")
            print(f"    {e}")
            failed += 1

    print(f"\n{'='*40}")
    print(f"  {passed} passed, {failed} failed")
    print(f"{'='*40}")
    return failed == 0


if __name__ == "__main__":
    success = run()
    sys.exit(0 if success else 1)
