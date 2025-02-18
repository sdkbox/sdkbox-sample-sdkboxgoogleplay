
#include "PluginGPGLuaHelper.h"
#include "PluginGPG/PluginGPG.h"
#include "PluginGPG/SnapshotManager.h"
#include "PluginGPG/SdkboxGooglePlayWrappedObjects.h"
#include "SnapshotMetadataLuaHelper.h"
#include "SDKBoxLuaHelper.h"

int register_all_PluginGPGLua_helper(lua_State* L) {
    return 1;
};

NativeLuaNotifierScheduler::NativeLuaNotifierScheduler(int id, const std::string& json)
	: _id(id)
	, _json(json)
{
}

void NativeLuaNotifierScheduler::schedule()
{
    retain();
    cocos2d::Director::getInstance()->getScheduler()->schedule(schedule_selector(NativeLuaNotifierScheduler::notity), this, 0, false);
    autorelease();
}

void NativeLuaNotifierScheduler::notity(float dt)
{
    lua_State* L = LuaEngine::getInstance()->getLuaStack()->getLuaState();
    lua_getglobal(L, "__nativeNotify");
    lua_pushinteger(L, _id);
    lua_pushstring(L, _json.c_str());
    auto ret = lua_pcall(L, 2, 0, 0);
    cocos2d::Director::getInstance()->getScheduler()->unscheduleAllForTarget(this);
    release();
}

void sdkbox::GPGWrapper::NotifyToScripting(int id, const std::string& str_json)
{
    NativeLuaNotifierScheduler* ns = new NativeLuaNotifierScheduler(id, str_json);
    ns->schedule();
}

