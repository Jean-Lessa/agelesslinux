# stubs.sh — no-op implementations of all module functions
#
# Source this after 00-header.sh to test main's flow without real implementations.
#
# Usage:
#   source lib/00-header.sh
#   source test/stubs.sh
#   source lib/99-main.sh
#   main --dry-run

# §§ OS-RELEASE stubs
analyze_os_release()  { echo "  [stub] analyze_os_release"; BASE_NAME="StubOS"; BASE_VERSION="1.0"; BASE_ID="stub"; BASE_ID_LIKE="stub"; AGELESS_ID_LIKE="stub"; }
plan_os_release()     { echo "  [stub] plan_os_release"; }
execute_os_release()  { echo "  [stub] execute_os_release"; }
revert_os_release()   { echo "  [stub] revert_os_release"; }
summary_os_release()  { echo "    [stub] summary_os_release"; }

# §§ COMPLIANCE stubs
plan_compliance()     { echo "  [stub] plan_compliance"; }
execute_compliance()  { echo "  [stub] execute_compliance"; }
revert_compliance()   { echo "  [stub] revert_compliance"; }
summary_compliance()  { echo "    [stub] summary_compliance"; }

# §§ USERDB stubs
analyze_userdb()      { echo "  [stub] analyze_userdb"; HAS_SYSTEMD=0; DM_NAME="unknown"; USERDBD_INSTALLED=0; USERDBD_ACTIVE=0; USERDB_DIR_EXISTS=0; USERDB_AVAILABLE=0; USERDB_BIRTHDATE_FOUND=0; PREVIOUS_INSTALL=0; HUMAN_USERS=(); HUMAN_UIDS=(); USERDB_EXISTING=(); USERDB_NEW=(); }
plan_userdb()         { echo "  [stub] plan_userdb"; }
execute_userdb()      { echo "  [stub] execute_userdb"; }
revert_userdb()       { echo "  [stub] revert_userdb"; }
summary_userdb()      { echo "    [stub] summary_userdb"; }

# §§ AGELESSD stubs
analyze_agelessd()    { echo "  [stub] analyze_agelessd"; }
plan_agelessd()       { echo "  [stub] plan_agelessd"; }
execute_agelessd()    { echo "  [stub] execute_agelessd"; }
revert_agelessd()     { echo "  [stub] revert_agelessd"; }
summary_agelessd()    { echo "    [stub] summary_agelessd"; }

# §§ CONF stubs
plan_conf()           { echo "  [stub] plan_conf"; }
write_conf()          { echo "  [stub] write_conf"; }
