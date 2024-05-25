/*
 * Copyright (C) 2024  Alfred Neumayer
 */

#ifndef DEVTOOLS_H
#define DEVTOOLS_H

#include <QObject>

class Tools: public QObject {
    Q_OBJECT

public:
    Tools();
    ~Tools() = default;

    Q_INVOKABLE bool check(const QString& tool);
    Q_INVOKABLE bool setup();
    Q_INVOKABLE void remove();
};

#endif
