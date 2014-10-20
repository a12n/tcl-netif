# TODO: Aliases?
proc netif {} {
    set ifconfig [exec /sbin/ifconfig]
    set ifstrs [_ssplit $ifconfig \n\n]
    set ans [dict create]
    foreach ifstr $ifstrs {
        set pattern {^(\S+).*inet addr:\s*(\S+).*MTU:\s*(\d+)}
        if {[regexp $pattern $ifstr _ ifnam ifaddr mtu]} {
            dict set ans $ifnam addrs $ifaddr
            dict set ans $ifnam mtu $mtu
        } else {
            error {Device has no address}
        }
    }
    return $ans
}
