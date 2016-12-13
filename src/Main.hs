module Main where

import Control.Concurrent

import System.Environment

import System.Posix.User

import System.Process

x :: CreateProcess
x = shell "X -terminate -config /etc/X11/xorg.conf -xkbdir /etc/X11/xkb :0 vt1 -logfile /home/travis/.xorg.log -nolisten tcp"

xmonad :: CreateProcess
xmonad = shell "xmonad"


main = do
    setUserID 0
    setEnv "XKB_BINDIR" "/nix/store/hzp06dm5fmjp3ccs86zv39m9fzc45mjl-xkbcomp-1.3.1/bin"
    createProcess x
    setUserID 1000
    setEnv "DISPLAY" ":0"
    (_, _, _, pc) <- createProcess xmonad
    callCommand "xrdb -merge ~/.Xresources"
    callCommand "xset r rate 200 50"
    callCommand "xsetroot -cursor_name left_ptr"
    waitForProcess pc
