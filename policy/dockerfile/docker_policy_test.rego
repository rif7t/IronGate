package docker.policy_test

# Test: No user specified
test_no_user_specified if {
    test_input := [
        {"Cmd": "from", "Value": ["alpine:3.19"]},
        {"Cmd": "run", "Value": ["echo hello"]},
        {"Cmd": "user", "Value": ["tom"]}
    ]

    deny := data.docker.policy.deny_no_user with input as test_input
    count(deny) == 0
}

# Test: user is root
test_user_is_root if {
    test_input := [
        {"Cmd": "user", "Value": ["r"]}
    ]

    deny := data.docker.policy.deny_root_user with input as test_input
    count(deny) == 0

}

# Test: ADD instead of COPY
test_use_copy_instead_of_add if {
    test_input := [
        {"Cmd": "copy", "Value": ["file.txt"]}
    ]

    deny := data.docker.policy.deny_add with input as test_input
    count(deny) == 0
}

# Test: FROM latest tag
test_no_latest_tag if {
    test_input := [
        {"Cmd": "from", "Value": ["ubuntu:3.12"]}
    ]

   deny := data.docker.policy.deny_latest_tag with input as test_input
    count(deny) == 0
}

# Test: Denylist commands
test_denylist_command if {
    test_input := [
        {"Cmd": "run", "Value": [""]}
    ]

    deny := data.docker.policy.deny_run_commands with input as test_input
    count(deny) == 0
}

# Test: Package installed without cache cleanup
test_package_install_without_cleanup if {
    test_input := [
        {"Cmd": "run", "Value": ["apt-get install nginx && rm -rf /var/lib/apt/lists/"]}
    ]

    warn_msgs := data.docker.policy.warn_package_cache with input as test_input
    count(warn_msgs) == 0
}


# Test: ENV secret detected
test_env_secret_detected if {
    test_input := [
        {"Cmd": "env", "Value": [""]}
    ]

    deny := data.docker.policy.deny_env_secrets with input as test_input
    count(deny) == 0
}

# Test: RUN secret detected
test_run_secret_detected if {
    test_input := [
        {"Cmd": "run", "Value": ["export"]}
    ]

    deny := data.docker.policy.deny_run_secrets with input as test_input
    count(deny) == 0
}
