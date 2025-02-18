LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := cocos2djs_shared

LOCAL_MODULE_FILENAME := libcocos2djs

LOCAL_ARM_MODE := arm

LOCAL_SRC_FILES := hellojavascript/main.cpp \
../../Classes/AppDelegate.cpp \
../../Classes/ide-support/SimpleConfigParser.cpp \
../../Classes/ide-support/RuntimeJsImpl.cpp \
../../Classes/SDKBoxJSHelper.cpp \
../../Classes/PluginGPGJS.cpp \
../../Classes/PluginGPGJSHelper.cpp

LOCAL_CPPFLAGS := -DSDKBOX_ENABLED
LOCAL_LDLIBS := -landroid \
-llog

LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../Classes \
./gpg/include/ \
$(LOCAL_PATH)/..

LOCAL_WHOLE_STATIC_LIBRARIES := sdkbox \
gpg-1 \
PluginGPG

LOCAL_STATIC_LIBRARIES := cocos2d_js_static
LOCAL_STATIC_LIBRARIES += cocos2d_simulator_static

include $(BUILD_SHARED_LIBRARY)
$(call import-add-path, $(LOCAL_PATH))

$(call import-module,scripting/js-bindings/proj.android/prebuilt-mk)
$(call import-module,tools/simulator/libsimulator/proj.android/prebuilt-mk)
$(call import-module, ./sdkbox)
$(call import-module, ./gpg)
$(call import-module, ./plugingpg)
