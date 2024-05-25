/*
 * Copyright (C) 2024  Alfred Neumayer
 */

#include <QtQml>
#include <QtQml/QQmlContext>

#include "plugin.h"
#include "tools.h"

void ExamplePlugin::registerTypes(const char *uri) {
    //@uri Example
    qmlRegisterSingletonType<Tools>(uri, 1, 0, "Tools", [](QQmlEngine*, QJSEngine*) -> QObject* { return new Tools; });
}
