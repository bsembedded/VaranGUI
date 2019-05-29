#include <QGuiApplication>
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QDebug>

#include "udpsendtogen.h"


int main(int argc, char *argv[])
{
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    if (qEnvironmentVariableIsEmpty("QTGLESSTREAM_DISPLAY")) {
        qputenv("QT_QPA_EGLFS_PHYSICAL_WIDTH", QByteArray("213"));
        qputenv("QT_QPA_EGLFS_PHYSICAL_HEIGHT", QByteArray("120"));

        QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    }

    //QGuiApplication app(argc, argv);
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    //QQuickView view(QUrl::fromLocalFile("qrc:/main.qml"));
    //QObject *item = (QObject *)view.rootObject();

    QObject *item = engine.rootObjects().first();

    UdpSendToGen myClass;
    QObject::connect(item, SIGNAL(qmlSignal900(QVariant)),
                    &myClass, SLOT(cppSlot900(QVariant)));

    QObject::connect(item, SIGNAL(qmlSignal1800(QVariant)),
                    &myClass, SLOT(cppSlot1800(QVariant)));

    QObject::connect(item, SIGNAL(qmlSignalPar(QVariant)),
                    &myClass, SLOT(cppSlotPar(QVariant)));

    return app.exec();
}
