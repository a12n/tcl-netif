proc netif {} {
    set ifconfig [exec /sbin/ifconfig]
    set ifstrs [_ssplit $ifconfig \n\n]
    set ans [dict create]
    foreach ifstr $ifstrs {
        set pattern {^(\S+).*inet addr:\s*(\S+)}
        if {[regexp $pattern $ifstr _ ifnam ifaddr]} {
            dict set ans $ifnam $ifaddr
        } else {
            error {Device has no address}
        }
    }
    return $ans
}
