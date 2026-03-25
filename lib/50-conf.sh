# §§ CONF — /etc/agelesslinux.conf installation record

plan_conf() {
    plan_action "Write ${CONF_PATH} (installation record)"
}

write_conf() {
    local install_date
    install_date=$(date -Iseconds 2>/dev/null || date "+%Y-%m-%dT%H:%M:%S%z")

    cat > "$CONF_PATH" << EOF
# /etc/agelesslinux.conf — Ageless Linux installation record
# Do not edit manually. Used by: become-ageless.sh --revert
# Written by become-ageless.sh ${AGELESS_VERSION} on ${install_date}
AGELESS_VERSION="${AGELESS_VERSION}"
AGELESS_CODENAME="${AGELESS_CODENAME}"
AGELESS_DATE="${install_date}"
AGELESS_FLAGRANT=${FLAGRANT}
AGELESS_PERSISTENT=${PERSISTENT}
AGELESS_BASE_NAME="${BASE_NAME}"
AGELESS_BASE_VERSION="${BASE_VERSION}"
AGELESS_BASE_ID="${BASE_ID}"
AGELESS_BACKED_UP_OS_RELEASE=${CONF_BACKED_UP_OS_RELEASE}
AGELESS_BACKED_UP_LSB_RELEASE=${CONF_BACKED_UP_LSB_RELEASE}
AGELESS_USERDB_DIR_CREATED=${CONF_USERDB_DIR_CREATED}
AGELESS_USERDB_CREATED="${CONF_USERDB_CREATED}"
AGELESS_USERDB_BACKED_UP="${CONF_USERDB_BACKED_UP}"
AGELESS_AGELESSD_INSTALLED=${CONF_AGELESSD_INSTALLED}
EOF

    echo ""
    echo -e "  [${GREEN}✓${NC}] Wrote ${CONF_PATH}"
}
