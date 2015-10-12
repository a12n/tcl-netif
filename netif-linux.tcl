# TODO: Aliases?
proc netif {} {
    set ifconfig [exec /sbin/ifconfig]
    set ifstrs [_ssplit $ifconfig \n\n]
    set ans [dict create]
    foreach ifstr $ifstrs {
        set pattern {^(\S+).*inet addr:\s*(\S+).*MTU:\s*(\d+).*RX bytes:\s*(\d+).*TX bytes:\s*(\d+)}
        set pattern2 {^(\S+):.*mtu\s+(\d+).*inet\s+(\S+).*RX.*bytes\s+(\d+).*TX.*bytes\s+(\d+)}
        if {[regexp $pattern $ifstr _ ifnam ifaddr mtu rx tx] || \
            [regexp $pattern2 $ifstr _ ifnam mtu ifaddr rx tx]} \
        {
            dict set ans $ifnam addrs $ifaddr
            dict set ans $ifnam mtu $mtu
            dict set ans $ifnam rx $rx
            dict set ans $ifnam tx $tx
        } else {
            error {Device is not configured}
        }
    }
    return $ans
}
