package docker.policy

# any user checks
deny_no_user contains msg if {
    not any_user
    msg := "Container must specify a non-root user"
}

any_user if {
    some idx
    input[idx].Cmd == "user"
}


deny_root_user contains msg if {
    some idx
    entry := input[idx]
    entry.Cmd == "user"
    entry.Value[idx] == "root"
    msg := sprintf("Line %d: Container must not run as root", [idx])
}

# ADD/COPY check
deny_add contains msg if {
    some idx
    entry := input[idx]
    entry.Cmd == "add"
    val := concat(" ", entry.Value)
    msg := sprintf("Use COPY instead of ADD: %s", [val])
}

# latest tag check
deny_latest_tag contains msg if {
    some idx
    entry := input[idx]
    entry.Cmd == "from"
    endswith(lower(entry.Value[0]), ":latest")
    msg := "do not use latest tag"
}

# Install Denylist commands
deny_run_commands contains msg if {
    some idx
    entry := input[idx]
    entry.Cmd == "run"
    val := entry.Value
    denylist := ["sudo", "curl.*|.*bash", ".*install.*ssh"]
    contains(val[_], denylist[_])
    msg := sprintf("unallowed commands found %s", [val])
}

# Package install without cleanup
warn_package_cache contains msg if {
    some idx
    entry := input[idx]
    entry.Cmd == "run"
    val := concat(" ", entry.Value)
    install_patterns := ["apt(-get)? .*install", "yum .*install", "dnf .*install", "apk .*add", "pip .*install"]
    cleanup_patterns := ["rm -rf /var/lib/apt/lists/", "yum clean all", "dnf clean all", "rm -rf /var/cache/apk/", "--no-cache-dir"]
    matches_any(val, install_patterns)
    not matches_any(val, cleanup_patterns)
    msg := sprintf("Line %d: Package installed without cleaning cache: %s", [idx, val])
}

matches_any(val, patterns) if {
    some i
    regex.match(patterns[i], val)
}

# Secrets
contains_secret(val) if{
    some i
    keyword := ["password","passwd","secret","token","apikey","api_key","key","access"][i]
    contains(lower(val), keyword)
}

deny_env_secrets contains msg if {
    some idx
    entry := input[idx]
    entry.Cmd == "env"
    val := concat(" ", entry.Value)
    contains_secret(val)
    msg := sprintf("Line %d: Potential secret found in ENV: %s", [idx, val])
}

deny_run_secrets contains msg if {
    some idx
    entry := input[idx]
    entry.Cmd == "run"
    val := concat(" ", entry.Value)
    contains_secret(val)
    msg := sprintf("Line %d: Potential secret found in RUN: %s", [idx, val])
}
