/*
 * Copyright (C) 2024  Alfred Neumayer
 */

#include <QDebug>
#include <QDir>
#include <QString>

#include <unistd.h>

#include "tools.h"

const auto localBinPath = QStringLiteral("/home/phablet/.local/bin");
const auto symlinkTemplate = localBinPath + QStringLiteral("/%1");
const QStringList tools = {
    QStringLiteral("node"),
    QStringLiteral("npm")
};

Tools::Tools() {

}

bool Tools::setup() {
    const auto wrapperTemplate = QStringLiteral("/opt/click.ubuntu.com/nodejs.fredldotme/current/lib/aarch64-linux-gnu/bin/%1.wrapper");

    QDir binDir(localBinPath);
    if (!binDir.exists())
        binDir.mkpath(localBinPath);

    if (!binDir.exists()) {
        qWarning() << "Failed to create target dir" << localBinPath;
        return false;
    }

#define CREATE_SYMLINK(tool) \
    (symlink(wrapperTemplate.arg(tool).toStdString().c_str(), symlinkTemplate.arg(tool).toStdString().c_str()))

    bool success = false;

    for (const auto& tool : tools) {
        qDebug() << "Linking" << wrapperTemplate.arg(tool) << "as" << symlinkTemplate.arg(tool);
        success |= (CREATE_SYMLINK(tool) == 0);
        if (!success)
            break;
    }
#undef CREATE_SYMLINK

    qDebug() << "Created all tools?" << success;

    return success;
}

void Tools::remove()
{
    for (const auto& tool : tools) {
        const auto path = symlinkTemplate.arg(tool);
        QFile file(path);
        qDebug() << "Removing file" << path << file.remove();
    }
}

bool Tools::check(const QString& tool) {
    return QFile::exists(symlinkTemplate.arg(tool));
}
