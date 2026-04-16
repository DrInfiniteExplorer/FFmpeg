# MSVC-style @response file expansion (see fftools/cmdutils.c prepare_app_arguments).
# Fixture copies: tests/Makefile rule tests/data/fftools-response-%.rsp

RESPONSE_FILE_FIXTURES = tests/data/fftools-response-version.rsp                  \
                          tests/data/fftools-response-nested-inner.rsp               \
                          tests/data/fftools-response-nested-outer.rsp               \
                          tests/data/fftools-response-multiline.rsp

fate-response-file-basic: ffprobe$(PROGSSUF)$(EXESUF) tests/data/fftools-response-version.rsp
fate-response-file-basic: CMD = run ffprobe$(PROGSSUF)$(EXESUF) -hide_banner @$(TARGET_PATH)/tests/data/fftools-response-version.rsp
fate-response-file-basic: CMP = null

fate-response-file-nested: ffprobe$(PROGSSUF)$(EXESUF) $(RESPONSE_FILE_FIXTURES)
fate-response-file-nested: CMD = run ffprobe$(PROGSSUF)$(EXESUF) -hide_banner @$(TARGET_PATH)/tests/data/fftools-response-nested-outer.rsp
fate-response-file-nested: CMP = null

fate-response-file-multiline: ffprobe$(PROGSSUF)$(EXESUF) tests/data/fftools-response-multiline.rsp
fate-response-file-multiline: CMD = run ffprobe$(PROGSSUF)$(EXESUF) @$(TARGET_PATH)/tests/data/fftools-response-multiline.rsp
fate-response-file-multiline: CMP = null

FATE_RESPONSE_FILE-$(CONFIG_FFPROBE) += fate-response-file-basic    \
                                        fate-response-file-nested    \
                                        fate-response-file-multiline

fate-response-file: $(FATE_RESPONSE_FILE-yes)
