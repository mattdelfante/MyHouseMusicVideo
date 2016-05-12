/****************************************************************************
**
** Copyright (C) 2015 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.0
import QtQuick.Particles 2.0

Rectangle {
    signal endScene
    //REMOVE
    property alias timer1: timer1

    id: window
    width: parent.width
    height: parent.height

    Connections{
        id: connectionTimer
        target: MyTimer
        onTimerTimeout:{

        }
    }

    //REMOVE
    Timer{
        id: timer1
        interval: 5000
        running: false

        onRunningChanged:
        {
            groundAnimation.running = true
            starsAnimation.running = true
            sunMoonStarsRotationAnimation.running = true
            skyGradientAnimation1.running = true
            skyGradientAnimation2.running = true
        }

        onTriggered:
        {
            nightToDayScene.visible = false
            closeBlindsScene.visible = true
            closeBlindsAnimation.running = true
            releaseBlindsDrawstringAnimation.running = true
            timer2.start()
            mattDancingUnderChampagne.playing = true
        }
    }

    //REMOVE
    Timer{
        id: timer2
        interval: 4500
        running: false

        onTriggered:
        {
            closeBlindsScene.visible = false
            clothesOnFloorScene.visible = true
            timer3.start()
            timer4.start()
        }
    }

    //REMOVE
    Timer{
        id: timer4
        interval: 4700
        running: false

        onTriggered:
        {
            clothesOnFloorScene.visible = false
            continueTonightScene.visible = true
            mattWalkingOntoFloorX.running = true
            mattWalkingOntoFloorY.running = true
            molliWalkingOntoFloorX.running = true
            molliWalkingOntoFloorY.running = true
            timer5.start()
        }
    }

    //REMOVE
    Timer{
        id: timer5
        interval: 4700
        running: false

        onTriggered:
        {
            continueTonightScene.visible = false
            endScene()
        }
    }

    Rectangle{
        id: nightToDayScene
        anchors.fill: parent

        //Sky gradient
        Rectangle {
            anchors { left: parent.left; top: parent.top; right: parent.right; bottom: parent.verticalCenter }
            gradient: Gradient {
                GradientStop {
                    position: 0.0
                    SequentialAnimation on color {
                        id: skyGradientAnimation1
                        running: false
                        loops: Animation.Infinite
                        ColorAnimation { from: "#0E1533"; to: "#14148c"; duration: 5000 }
                        ColorAnimation { from: "#14148c"; to: "#0E1533"; duration: 5000 }
                    }
                }
                GradientStop {
                    position: 1.0
                    SequentialAnimation on color {
                        id: skyGradientAnimation2
                        running: false
                        loops: Animation.Infinite
                        ColorAnimation { from: "#437284"; to: "#14aaff"; duration: 5000 }
                        ColorAnimation { from: "#14aaff"; to: "#437284"; duration: 5000 }
                    }
                }
            }
        }

        //Sun, moon, stars
        Item {
            width: parent.width; height: 2 * parent.height
            NumberAnimation on rotation {
                id: sunMoonStarsRotationAnimation
                running: false
                from: -140; to: 220; duration: 10000; loops: Animation.Infinite
            }
            Image {
                width: .0625 * parent.width
                height: width
                source: "../images/sun.png"; y: 10; anchors.horizontalCenter: parent.horizontalCenter
                rotation: -3 * parent.rotation
            }
            Image {
                width: .0625 * parent.width
                height: .8 * width
                source: "../images/moon.png"; y: parent.height - 74; anchors.horizontalCenter: parent.horizontalCenter
                rotation: -parent.rotation
            }
            ParticleSystem {
                id: particlesystem
                x: 0; y: parent.height/2
                width: parent.width; height: parent.height/2
                ImageParticle {
                    width: 2
                    height: 2
                    source: "../images/star.png"
                    groups: ["star"]
                    color: "#00333333"
                    SequentialAnimation on opacity {
                        id: starsAnimation
                        running: false
                        loops: Animation.Infinite
                        NumberAnimation { from: 0; to: 1; duration: 5000 }
                        NumberAnimation { from: 1; to: 0; duration: 5000 }
                    }
                }
                Emitter {
                    group: "star"
                    anchors.fill: parent
                    emitRate: parent.width / 50
                    lifeSpan: 5000
                }
            }
        }

        //Ground gradient
        Rectangle {
            anchors { left: parent.left; top: parent.verticalCenter; right: parent.right; bottom: parent.bottom }
            gradient: Gradient {
                GradientStop {
                    position: 0.0
                    SequentialAnimation on color {
                        id: groundAnimation
                        running: false
                        loops: Animation.Infinite
                        ColorAnimation { from: "#001600"; to: "#80c342"; duration: 5000 }
                        ColorAnimation { from: "#80c342"; to: "#001600"; duration: 5000 }
                    }
                }
                GradientStop { position: 1.0; color: "#006325" }
            }
        }

        Image
        {
            id: mansion
            source: "../images/mansion.png"
            width: height
            height: .3 * parent.height
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -.1 * parent.height
        }
    }

    Rectangle{
        id: closeBlindsScene
        width: parent.width
        height: parent.height
        visible: false

        Image{
            id: openedWindow
            source: "../images/openedWindow.jpg"
            anchors.fill: parent

            AnimatedImage{
                id: mattDancingInWindow
                source: "../images/mattPerson/dancingGifMatt.gif"
                width: height/2
                height: molliHoldingBlinds.height
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: parent.height/17
            }

            Image{
                id: blinds
                source: "../images/blinds.png"
                width: window.width
                x: 0
                y: .13 * parent.height

                PropertyAnimation
                {
                    id: closeBlindsAnimation
                    target: blinds
                    properties: "height"
                    from: .1 * window.height
                    to: .87 * window.height
                    duration: 4500
                    running: false
                }
            }

            Image{
                id: blindsDrawstring
                source: "../images/blindsDrawstring.png"
                width: window.width
                x: 0
                y: .12 * parent.height

                PropertyAnimation
                {
                    id: releaseBlindsDrawstringAnimation
                    target: blindsDrawstring
                    properties: "height"
                    from: .906* window.height
                    to: .5 * window.height
                    duration: 4500
                    running: false
                }
            }

            Image{
                id: molliHoldingBlinds
                source: "../images/molliPerson/molliHoldingBlinds.png"
                width: .186 * parent.width
                height: .454 * parent.height
                anchors.bottom: blindsDrawstring.bottom
                anchors.left: parent.left
            }
        }
    }

    Rectangle{
        id: clothesOnFloorScene
        width: parent.width
        height: parent.height
        visible: false

        Image{
            id: jerseysOnFloor
            source: "../images/jerseysOnFloor.png"
            anchors.fill: parent
            opacity: .75
        }

        Timer{
            id: timer3
            interval: 1700
            running: false

            onTriggered:{
                champagneBottle.playing = true
            }
        }

        AnimatedImage{
            id: mattDancingUnderChampagne
            source: "../images/mattPerson/dancingGifMatt.gif"
            width: .1875 * parent.width
            height: .6 * parent.height
            anchors.left: champagneBottle.horizontalCenter
            anchors.leftMargin: parent.width/8
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height/12
            playing: false
        }

        Image{
            id: mattSpeaking
            source: "../images/speechBubble.png"
            width: parent.width/6
            height: parent.height/6
            x: mattDancingUnderChampagne.x + mattDancingUnderChampagne.width
            y: mattDancingUnderChampagne.y
            visible: false

            Text{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                text: "...Thanks."
                font.pixelSize: parent.height/6
            }
        }

        AnimatedImage{
            id: champagneBottle
            source: "../images/champagneGif.gif"
            width: parent.width * .8
            height: (parent.height * 1.2) * .8
            x: parent.width/2 - width/2
            y: parent.height/2 - height/2
            playing: false

            onFrameChanged: {
                if (currentFrame === 12)
                {
                    mattDancingUnderChampagne.playing = false
                }

                if (currentFrame === 20)
                {
                    mattSpeaking.visible = true
                }
            }
        }

        Image{
            id: molliHoldingBottle
            source: "../images/molliPerson/molliHoldingBlinds.png"
            width: .242 * parent.width
            height: .59 * parent.height
            anchors.right: champagneBottle.horizontalCenter
            anchors.rightMargin: parent.width/16
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height/12
        }
    }

    Rectangle{
        id: continueTonightScene
        width: parent.width
        height: parent.height
        visible: false

        AnimatedImage{
            id: changingSpotLights
            source: "../images/changingSpotLights.gif"
            anchors.fill: parent
        }

        Image{
            id: mattWalking
            source: "../images/mattPerson/mattStanding.png"
            width: 80
            height: 232

            NumberAnimation{
                id: mattWalkingOntoFloorX
                target: mattWalking
                properties: "x"
                from: 0
                to: 325
                duration: 2000
                running: false
            }

            NumberAnimation{
                id: mattWalkingOntoFloorY
                target: mattWalking
                properties: "y"
                from: 250
                to: 150
                duration: 2000
                running: false
            }
        }

        Image{
            id: molliWalking
            source: "../images/molliPerson/molliStanding.png"
            width: 118
            height: 245

            NumberAnimation{
                id: molliWalkingOntoFloorX
                target: molliWalking
                properties: "x"
                from: 0
                to: 425
                duration: 2000
                running: false
            }

            NumberAnimation{
                id: molliWalkingOntoFloorY
                target: molliWalking
                properties: "y"
                from: 250
                to: 150
                duration: 2000
                running: false

                onRunningChanged:
                {
                    if (running === false)
                    {
                        mattWalking.visible = false
                        molliWalking.visible = false
                        mattDancing.visible = true
                        molliDancing.visible = true
                        mattDancing.playing = true
                        molliDancing.playing = true
                    }
                }
            }
        }

        AnimatedImage{
            id: mattDancing
            source: "../images/mattPerson/dancingGifMatt.gif"
            width: 100 * 1.3
            height: 200 * 1.3
            x: 310
            y: 142
            playing: false
            visible: false
        }

        AnimatedImage{
            id: molliDancing
            source: "../images/molliPerson/dancingGifMolli.gif"
            width: 100 * 1.3
            height: 200 * 1.3
            x: 419
            y: 142
            playing: false
            visible: false
        }
    }
}


