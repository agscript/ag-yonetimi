#!/bin/bash
PATH=/bin:/usr/bin:/usr/local/bin:$PATH
export PATH
#export LC_ALL=C

function ag_durumu {
red='\e[1;91m'; cyan='\e[1;36m'; magenta='\e[1;35m'; yellow='\e[1;33m'; white='\e[1;97m'; blue='\e[2;34m'; son='\e[0m'
clear; sudo echo ""; clear
_baglanti_bilgilerim () {
[[ -d /tmp/agtest ]] && rm -r /tmp/agtest
mkdir -p /tmp/agtest
TEST="/tmp/agtest"
CHZE=$(ifconfig -s | awk '/BMRU/{print $1}' | sed -n 1p | cut -c1)
EUG=$(route -n | awk '/UG/{ print $8}'| cut -c1 | grep 'e' | sed -n 1p)
WUG=$(route -n | awk '/UG/{ print $8}'| cut -c1 | grep 'w' | sed -n 1p)
CHZ=$(ifconfig -s | awk '/BMRU/{print $1}' | sed -n 1p)
CHZS=$(ifconfig -s | grep 'BMRU' | awk 'END { print NR }')
CHZA=$(ifconfig -s | awk '/BMRU/{print $1}' | sed -n 1p | cut -c1)
CHZW=$(ifconfig -s | awk '/BMRU/{print $1}' | sed -n 2p | cut -c1)
clear; echo -e "\n\t\t\t\t$blue Genel Bilgiler$son\n"

_wifi () {
YER=$(iw dev $KCHZ1 link | awk '/SSID/{print $2}')
DADR=$(iw dev $KCHZ1 link | awk '/Connected/{print $3}')
KALITE=$(iwconfig $KCHZ1 | awk '/Link Quality/{print $2}' | sed 's/Quality=//g')
SSVY=$(iwconfig $KCHZ1 | awk '/Signal level/{print $4,$5}'| sed 's/level=//')
CIHAZW=$(lspci | grep 'Network' | cut -d" " -f4-16)
KANAL=$(iwlist $KCHZ1 channel | awk '/Current/{print $5}' | sed 's/)//')
FREK=$(iwlist $KCHZ1 channel | awk '/Current/{print $2}' | cut -c11-18)
VRHZ=$(iwlist $KCHZ1 bitrate | awk '/Current/{print $3,$4}' | cut -c6-15)
WSRC=$(ethtool -i $KCHZ1 | awk '/driver/{print $2}')
VERS=$(ethtool -i $KCHZ1 | awk '/^version/{print $2}')
PCIP1=$(ifconfig $KCHZ1 | awk '/inet/{print $2}' | sed -n -e 's/addr://g' -e 1p)
MacA=$(ifconfig $KCHZ1 | awk '/ether/{print $1}')
if [[ $MacA = 'ether' ]]; then MASK=$(ifconfig $KCHZ1 | awk '/netmask/{print $4}')
    else MASK=$(ifconfig $KCHZ1 | awk '/Mask/{print $4}' | sed -n -e 's/Mask://g' -e 1p); fi
fping -c1 t200 $PCIP1 &>$TEST/ipkont
MTST=$(cat $TEST/ipkont | grep 'bytes'| awk '{print $5}' | cut -c1-5)
if [[ $MTST = 'bytes' ]]; then SNC=$(echo -e "$cyan Veri Akışı Var$son")
	 else SNC=$(echo -e "$red Veri Akışı Yok$son"); fi
echo -ne "\n$red [ W ]$blue Ayrıntılar $son $magenta  Wifi:$yellow $YER $magenta IP:$yellow $PCIP1$son  = $SNC \n\n"

}
_kablo () {
sudo ethtool $KCHZ2 >$TEST/etht
sudo ethtool -i $KCHZ2 >$TEST/etbl
if [[ -x /usr/bin/nmcli ]]; then EDADR=$(nmcli dev show $KCHZ2 | awk '/HWADDR/{print $2}')
	 else EDADR=$(ifconfig $KCHZ2 | awk '/ether/{print $2}'); fi
EAGG=$(route -n | awk '/UG/{ print $2}' | sed -n 1p)
CIHAZE=$(lspci | grep 'Ethernet' | cut -d" " -f4,8-12)
ESRC=$(cat $TEST/etbl | awk '/driver/{print $2}')
EVERS=$(cat $TEST/etbl | awk '/^version/{print $2}')
BAGD=$(cat $TEST/etht | grep 'Link detected' | awk '{print $3}')
EVRHZ=$(cat $TEST/etht | awk '/Speed/{print $2}')
PORTS=$(cat $TEST/etht | awk '/Supported link modes:/{f=1;next} /Supported pause frame/{f=0} f' | tail -n1 -c16 | sed -e 's/^[[:space:]]*//' -e 's/\//:/')
PCIP2=$(ifconfig $KCHZ2 | awk '/inet/{print $2}' | sed -n -e 's/addr://g' -e 1p)
MacA=$(ifconfig $KCHZ2 | awk '/ether/{print $1}')
if [[ $BAGD = 'yes' ]]; then EBAG='Var'; else EBAG='Yok'; fi
if [[ $MacA = 'ether' ]]; then MAD=$(ifconfig $KCHZ2 | awk '/ether/{print $2}' | sed -n 1p)
	MASK=$(ifconfig $KCHZ2 | awk '/netmask/{print $4}')
	    else MAD=$(ifconfig $KCHZ2 | awk '/HWaddr/{print $5}')
		    MASK=$(ifconfig $KCHZ1 | awk '/Mask/{print $4}' | sed -n -e 's/Mask://g' -e 1p); fi
fping -c1 t200 $PCIP2 &>$TEST/kakont
KTST=$(cat $TEST/kakont | grep 'bytes'| awk '{print $5}' | cut -c1-5)
if [[ $KTST = 'bytes' ]]; then SNB=$(echo -e "$cyan Veri Akışı Var$son"); else SNB=$(echo -e "$red Veri Akışı Yok$son"); fi
 echo -e "\n$red [ E ]$blue Ayrıntılar $son $magenta  Kablo:$yellow Bağlı $magenta IP:$yellow $PCIP2$son  = $SNB \n"
}
_modemkont () {
MODEMIP=$(route -n | awk '/UG/{ print $2}' | sed -n 1p)
if [[ (($EUG = 'e') && ($CHZA = 'e')) ]]; then TLIP=$(curl --interface "$KCHZ2" -s http://ipecho.net/plain; &>/dev/null)
else TLIP=$(curl -s http://ipecho.net/plain; &>/dev/null) ; fi
fping -c1 -t100 www.google.com &>$TEST/netkont
NTST=$(cat $TEST/netkont | awk '/bytes/{print $5}' | cut -c1-5)
if [[ $NTST = 'bytes' ]]; then SNI=$(echo -e "$cyan Net Erişimi Var$son"); else SNI=$(echo -e "$red Net Erişimi Yok$son"); fi
echo -ne "\n$red [ N ]$blue Ayrıntılar $son $magenta  D-IP:$yellow $TLIP$son  = $SNI \n\n"
}
_kabtest () {
KART=$(lspci -k 2>0 | awk '/Ethernet/,0'| awk '/Kernel driver/{print $3}')
KDRM=$(dmesg | grep $KART | tail -n1 -c5)
UGS=$(cat /proc/net/dev | grep '^e' | awk '{print $1}'| sed 's/://')
if [[ (($KDRM = 'down') && ($CHZE = 'w') && ($EUG = 'e')) ]]; then sudo ifconfig $UGS down ; fi
#ETHT=$(ip link show | grep LOWER_UP | awk '{print $2}'| grep 'e' | cut -c1)
if [[ (($CHZE = 'w') && ($EUG != 'e') && ($KDRM = 'down')) ]]; then
echo -ne "\n$red [ A ]$blue Kablolu aygıtı aç ve yenile $son \n\n"; fi
}

if [[ (($CHZS -eq '1') && ($WUG = 'w')) ]]; then KCHZ1=$(ifconfig -s | awk '/BMRU/{print $1}' | sed -n 1p); _kabtest; _wifi
 else if [[ (($CHZS -eq '1') && ($EUG = 'e')) ]]; then KCHZ2=$(ifconfig -s | awk '/BMRU/{print $1}' | sed -n 1p); _kablo; fi; fi
	if [[ $CHZS -eq '2' ]]; then if [[ (( $WUG = 'w' ) && ( $EUG = 'e' )) ]]; then 
		KCHZ1=$(ifconfig -s | awk '/BMRU/{print $1}' | sed -n -e 2p)
      			KCHZ2=$(ifconfig -s | awk '/BMRU/{print $1}' | sed -n 1p); _kablo; _wifi
	elif [[ (( $WUG = 'w' ) && ( $EUG != 'e' )) ]]; then
				KCHZ1=$(ifconfig -s | awk '/BMRU/{print $1}' | sed -n -e 2p); _wifi
	elif [[ (( $EUG != 'e' ) && ( $WUG = 'w' )) ]]; then
				KCHZ2=$(ifconfig -s | awk '/BMRU/{print $1}' | sed -n -e 1p); _kablo; fi; fi

if [[ ($CHZS -ge '1') && (($WUG = 'w') || ($EUG = 'e')) ]]; then _modemkont; else echo -e "\n\t\t\t$red Ağa bağlı hiçbir cihaz bulunamadı$son"; fi

echo -ne "\n\n$blue***********************************************************************$son\n\n\n  $red[ P ]$white Ping İşlemi \t  $red[ K ]$white Kablosuz Ağlar \t $red[ T ]$white İP Tarama \n\v\v  $red[ M ]$white Modem arayüzü \t  $red[ Y ]$white Sayfa Yenile \t $red[ C ]$white Çıkış..$son\n\n "

_tarayici () {
GOO="/usr/bin/google-chrome-stable"
  FIRE="/usr/bin/firefox"
   CHROM="/usr/bin/chromium"
     OPERA="/usr/bin/opera"
if [ -x $GOO 2>/dev/null ]; then TRYC='google-chrome-stable'; elif [ -x $FIRE 2>/dev/null ]; then TRYC='firefox'
 elif [ -x $CHROM 2>/dev/null ]; then TRYC='chromium'; elif [ -x $OPERA 2>/dev/null ]; then TRYC='opera'
   else clear; echo -e "\n $red Uygun Tarayıcı Bulunamadı...$son\n"; sleep 3; _baglanti_bilgilerim; fi
}

_Arch_dns () {
DNS1=$(cat /etc/resolv.conf | awk '/nameserver/{print $2}'| sed -n 1p)
   DNS2=$(cat /etc/resolv.conf | awk '/nameserver/{print $2}'| sed -n 2p)
DNS3=$(cat /etc/resolv.conf | awk '/nameserver/{print $2}'| sed -n 3p)
   DNS4=$(cat /etc/resolv.conf | awk '/nameserver/{print $2}'| sed -n 4p)
if [[ "$ARDN" -eq '1' ]]; then echo -e "$magenta DNS1:$yellow $DNS1$son\n\n"
  elif [[ "$ARDN" -eq '2' ]]; then echo -e "$magenta DNS1:$yellow $DNS1 $magenta DNS2:$yellow $DNS2$son\n\n"
  elif [[ "$ARDN" -eq '3' ]]; then echo -e "$magenta DNS1:$yellow $DNS1 $magenta DNS2:$yellow $DNS2 $magenta DNS3:$yellow $DNS3$son\n\n"
  elif [[ "$ARDN" -ge '4' ]]; then echo -e "$magenta DNS1:$yellow $DNS1 $magenta DNS2:$yellow $DNS2 $magenta DNS3:$yellow $DNS3 $magenta DNS4:$yellow $DNS4$son\n"
 fi
}
ARDN=$(cat /etc/resolv.conf|grep nameserver|awk 'END{print NR}')

read apkhmtwenyc
case $apkhmtwenyc in
	[aA] )
		clear; echo -e "\n\n $cyan Aygıt açılıyor bekleyin ..... $son\n\n"
		sudo ifconfig $UGS up ; rm /tmp/ekp 2>/dev/null
		sudo systemctl restart NetworkManager.service; sleep 8; _baglanti_bilgilerim
		;;
	[wW] )
		_wfdetay () {
		clear; echo -e "\t\t\t$blue Kablosuz Bağlantı Ayrıntıları$son\n\n\n$magenta Aygıt: $yellow$CIHAZW\n\n\n$magenta Sürücü: $yellow$WSRC  $magenta  Sürüm: $yellow$VERS  $magenta  Donanım Adresi: $yellow$DADR\n\n\n$magenta Bağlantı: $yellow$YER  $magenta  Sİnyal Seviyesi: $yellow$SSVY  $magenta  Sinyal Kalitesi: $yellow$KALITE\n\n\n$magenta Frekans: $yellow$FREK GHz $magenta  Kanal: $yellow$KANAL  $magenta  Aktarım Hızı: $yellow$VRHZ $magenta  IP: $yellow$PCIP1 $son\n\n"

		_wdnsaddr () {
		nmcli dev show $KCHZ1 | awk '/IP4.DNS/{print $2}' >$TEST/wdns
					 WDNS=$(cat $TEST/wdns | awk 'END { print NR }')
					 WDNS1=$(cat $TEST/wdns | sed -n 1p)
					 WDNS2=$(cat $TEST/wdns | sed -n 2p)
					 WDNS3=$(cat $TEST/wdns | sed -n 3p)
					 WDNS4=$(cat $TEST/wdns | sed -n 4p)
		if [[ "$WDNS" -eq '1' ]]; then echo -e "$magenta DNS1:$yellow $WDNS1$son\n\n"
 		  elif [[ "$WDNS" -eq '2' ]]; then echo -e "$magenta DNS1:$yellow $WDNS1 $magenta DNS2:$yellow $WDNS2$son\n\n"
 		  elif [[ "$WDNS" -eq '3' ]]; then echo -e "$magenta DNS1:$yellow $WDNS1 $magenta DNS2:$yellow $WDNS2 $magenta DNS3:$yellow $WDNS3$son\n\n"
 		  elif [[ "$WDNS" -ge '4' ]]; then echo -e "$magenta DNS1:$yellow $WDNS1 $magenta DNS2:$yellow $WDNS2 $magenta DNS3:$yellow $WDNS3 $magenta DNS4:$yellow $WDNS4$son\n"
 		fi
		}
		if [[ -x /usr/bin/nmcli ]]; then _wdnsaddr; else if [[ "$ARDN" -ge '1' ]]; then _Arch_dns; fi; fi
		echo -ne "\n$blue***********************************************************************$son\n\n\n   $red [ Y ]$white Yenile \t  $red [ A ]$white Ana Seçenekler \t$red[ C ]$white Çıkış..$son\n\n "
			read yac; case $yac in 
				[yY] ) clear; _wfdetay ;; [aA] ) _baglanti_bilgilerim ;; [cC] ) clear; exit ;; esac
		} ; _wfdetay
		;;
	[eE] )
		_ethdetay () {
		clear; echo -e "\t\t\t$blue Kablolu Bağlantı Ayrıntıları$son\n\n\n$magenta Aygıt: $yellow$CIHAZE\n\n\n$magenta Sürücü: $yellow$ESRC  $magenta  Sürüm: $yellow$EVERS  $magenta  Donanım Adresi: $yellow$EDADR\n\n\n$magenta Bağlantı: $yellow$EBAG  $magenta  Port: $yellow$PORTS  $magenta  Aktarım Hızı: $yellow$EVRHZ\n\n\n$magenta Ağ Geçidi: $yellow$EAGG $magenta IP: $yellow$PCIP2 $son\n\n"

		_EDNSaddr () {
		nmcli dev show $KCHZ2 | awk '/IP4.DNS/{print $2}' >$TEST/edns
					 EDNS=$(cat $TEST/edns | awk 'END { print NR }')
			    		 EDNS1=$(cat $TEST/edns | sed -n 1p)
					 EDNS2=$(cat $TEST/edns | sed -n 2p)
					 EDNS3=$(cat $TEST/edns | sed -n 3p)
					 EDNS4=$(cat $TEST/edns | sed -n 4p)
		if [[ "$EDNS" -eq '1' ]]; then echo -e "$magenta DNS1:$yellow $EDNS1$son\n\n"
		   elif [[ "$EDNS" -eq '2' ]]; then echo -e "$magenta DNS1:$yellow $EDNS1 $magenta DNS2:$yellow $EDNS2$son\n\n"
		   elif [[ "$EDNS" -eq '3' ]]; then echo -e "$magenta DNS1:$yellow $EDNS1 $magenta DNS2:$yellow $EDNS2 $magenta DNS3:$yellow $EDNS3$son\n\n"
		   elif [[ "$EDNS" -ge '4' ]]; then echo -e "$magenta DNS1:$yellow $EDNS1 $magenta DNS2:$yellow $EDNS2 $magenta DNS3:$yellow $EDNS3 $magenta DNS4:$yellow $EDNS4$son\n"
		fi
		}
		if [[ -x /usr/bin/nmcli ]]; then _EDNSaddr; else if [[ "$ARDN" -ge '1' ]]; then _Arch_dns; fi; fi
		echo -ne "\n$blue***********************************************************************$son\n\n\n   $red [ Y ]$white Yenile \t  $red [ A ]$white Ana Seçenekler \t$red[ C ]$white Çıkış..$son\n\n "
			read yac; case $yac in 
				[yY] ) clear; _ethdetay ;; [aA] ) _baglanti_bilgilerim ;; [cC] ) clear; exit ;; esac
		}; _ethdetay
		;;
        [nN] )		
		_netbil () {
		echo -e "\n\n $cyan Bilgiler alınıyor.. Bekleyin !.....$son\n\n"
		HTEST=/tmp/agtest/speedtest/
		SURE=5
		rm -rf $HTEST && mkdir $HTEST
		links=("http://client.cdn.gamigo.com/bp/eu/com/110a/BPClientSetup-2b.bin" "http://client.cdn.gamigo.com/bp/eu/com/110a/BPClientSetup-1b.bin" "http://client.cdn.gamigo.com/bp/eu/com/110a/BPClientSetup-1c.bin" "http://ftp.ntua.gr/pub/linux/ubuntu-releases-dvd/quantal/release/ubuntu-12.10-server-armhf+omap.img" "http://ftp.funet.fi/pub/Linux/INSTALL/Ubuntu/dvd-releases/releases/12.10/release/ubuntu-12.10-server-armhf+omap.img" "http://ftp.icm.edu.pl/pub/Linux/opensuse/distribution/13.2/iso/openSUSE-13.2-DVD-x86_64.iso")
		for link in ${links[*]}
		do
		    timeout $SURE wget -q -P $HTEST $link &
		done; wait
		TOPBYTE=$(du -c $HTEST | awk '/toplam/{print $1}')
		speed=$(expr $TOPBYTE / $SURE)
		sonuc=$(echo "scale=2;$speed/106" | bc)
		HIZ=$(echo -e "$sonuc Mbps")

		clear; echo -e "\n\n\t\t\t$blue İnternet Bağlantı Ayrıntıları$son\n\n\n\t $magenta Ağ-Maskesi:$yellow $MASK \t $magenta Modem-IP:$yellow $MODEMIP$son \n\n\n\t $magenta Bağlantı Hızı:$yellow $HIZ \t $magenta Dış-IP:$yellow $TLIP$son\n"
		echo -ne "\n\n$blue***********************************************************************$son\n\n\n  $red [ Y ]$white Yenile \t  $red [ A ]$white Ana Seçenekler \t$red[ C ]$white Çıkış..$son\n\n "
			read yac; case $yac in 
				[yY] ) clear; _netbil ;; [aA] ) _baglanti_bilgilerim ;; [cC] ) clear; exit ;; esac
		}; clear; _netbil
                ;;
        [pP] )
		_ping () {
		_arayuz () {
		echo -ne "\n\n$blue**************************************************************************$son\n\n\n $red [ B ] $yellow$IP$white adresine bağlanın \t$red[ A ]$white Ana Seçenekler\t$red[ C ]$white Çıkış..$son\n\n "
			read bac; case $bac in 
				[bB] ) _tarayici; $TRYC $IP &>/dev/null; clear; _secenekler ;; [aA] ) _baglanti_bilgilerim ;; [cC] ) clear; exit ;; esac
		}
		_adress () {
		clear; echo -e "\n\t\t\t\t $blue Ping İşlemi$son\n\n";  read -p " Adresi Girin :  " IP; echo -e "\n\n$blue**************************************************************************$son\n" 
			ATST=$(fping -c1 -t100 $IP | awk '/bytes/{print $5}' | cut -c1-5)
				if [[ $ATST = 'bytes' ]]; then echo -e "\n\n\n\t $magenta $IP için :$son Ping Testi Tamamlandı$cyan Bağlantı Var$son"; _arayuz
								     else echo -e "\n\n\n\t $magenta $IP için :$son Ping Testi Olumsuz $red Bağlantı Kurulamadı$son\n"; _secenekler ; fi
		}
		_secenekler () {
		echo -ne "\n\n$blue**************************************************************************$son\n\n\n  $red [ Y ]$white Yeni adres \t  $red [ A ]$white Ana Seçenekler \t$red[ C ]$white Çıkış..$son\n\n "
			read yac; case $yac in 
				[yY] ) _adress ;; [aA] ) _baglanti_bilgilerim ;; [cC] ) clear; exit ;; esac
		}
		clear; echo -e "\n\t\t\t\t $blue Ping İşlemi$son\n\n";  read -p " Adresi Girin :  " IP
		 echo -e "\n\n$blue******************************************************************************$son\n"
		ATST=$(fping -c1 -t100 $IP | awk '/bytes/{print $5}' | cut -c1-5)
		if [[ $ATST = 'bytes' ]]; then echo -e "\n\n\n\t $magenta $IP için :$son Ping Testi Tamamlandı$cyan Bağlantı Var$son"; _arayuz
							 else echo -e "\n\n\n\t $magenta $IP için :$son Ping Testi Olumsuz $red Bağlantı Kurulamadı$son\n" ; fi
		echo -ne "\n\n$blue******************************************************************************$son\n\n\n  $red [ Y ]$white Yeni adres \t  $red [ A ]$white Ana Seçenekler  $red  [ C ]$white Çıkış..$son\n\n "
			read yac; case $yac in 
				[yY] ) _adress ;; [aA] ) _baglanti_bilgilerim ;; [cC] ) clear; exit ;; esac
		}
				if [[ ($CHZS -ge '1') && (($WUG = 'w') || ($EUG = 'e')) ]]; then _ping
		 else clear; echo -e "\n\n $red Bu işlemi yapabilmeniz için etkin bir ağa bağlı olmanız gerekiyor. \n\n  Bağlantınızı kontrol edip tekrar deneyin.. \n\n $yellow Ana menüye dönülecek..$son\n\n"
		 sleep 4; clear; _baglanti_bilgilerim; fi 
                ;;
        [kK] )
		_wifi_tarama () {
		WK=$(ifconfig -s | awk '/BMU|BMRU/{print $1}' | grep 'w' | cut -c1)
		_Network_Manager () {
		clear; echo -e "\n\t\t\t\t $blue Kullanılabilir Kablosuz Ağlar$son\n\n\t$yellow Ağ Listesi \t\t      Kip Kanal      Oran      Sinyal      Güvenlik$son"
		nmcli dev wifi | grep -v 'SSID' | awk 'FNR <= 20 {print "\n "$n}'
		}
		_X_Manager () {
		clear; echo -e "\t\t\t $blue Kullanılabilir Kablosuz Ağlar$son\n\n"
		sudo iw dev $KCHZ1 scan | grep -v '^$' | sed '/^\s*$/d' | awk '/SSID/{print "\n\t\t\t\t " $2}' >$TEST/wifi
		echo " "; cat $TEST/wifi | awk 'FNR <= 20' ; rm $TEST/wifi 2>/dev/null
		}
		if [[ (($WK = 'w') && ( -x /usr/bin/nmcli)) ]]; then _Network_Manager; else if [[ $WK = 'w' ]]; then _X_Manager
			 else clear; echo -e "\n\n $red Ağ taraması yapabilmeniz için kablosuz alıcınızın olması veya\n\n  kapalı ise donanımın açık olması gerekiyor!$son\n\n"; fi; fi 
		echo -ne "\n\n$yellow***************************************************************************************$son\n\n\n  $red  [ Y ]$white Yeniden tara \t $red[ B ]$white Bağlan \t $red [ A ]$white Ana Seçenekler \t $red [ C ]$white Çıkış..$son\n\n "
			read ybac; case $ybac in 
			[yY] ) clear; _wifi_tarama ;; 
			[bB] ) sudo pkill wifi-menu; sudo -S gnome-terminal --hide-menubar --geometry=85x35 --zoom=1.4 -e wifi-menu &>/dev/null
			sleep 1; _baglanti_bilgilerim ;;
			[aA] ) _baglanti_bilgilerim ;; [cC] ) clear; exit ;; esac
		} ; clear; _wifi_tarama
                ;;
        [mM] )
		_modem_arayuzu () {
		_tarayici
 		$TRYC $MODEMIP &>/dev/null
		 _baglanti_bilgilerim
		}
		if [[ ($CHZS -ge '1') && (($WUG = 'w') || ($EUG = 'e')) ]]; then _modem_arayuzu
		 else clear; echo -e "\n\n $red Bilgisayarınız herhangi bir modeme bağlı değil \n\n $yellow Ana menüye dönülecek..$son\n\n"
		 sleep 3; clear; _baglanti_bilgilerim; fi
                ;;
	[tT] )
		_tarama () {
		MIP=$(route -n | awk '/UG/{ print $2}' | sed -n -e 1p | cut -c1-2)
		if [[ $MIP = '19' ]]; then IPARA=$(route -n | awk '/UG/{ print $2}' | sed -n 1p | cut -c1-9); elif [[ $MIP = '10' ]]; then IPARA=$(route -n | awk '/UG/{ print $2}' | sed -n 1p | cut -c1-6); else clear; echo -e "\n $red Ağ geçidiniz öngörülen ip aralığında değil. Önceki menüye dönülecek..$son\n"; sleep 3; clear; _baglanti_bilgilerim ; fi
		clear; echo -e "\n\n"; fping -c1 -g $IPARA.0/24
		rm $TEST/scan 2>/dev/null
		arp -an | sed '/<incomplete>/d' | grep ') at' | awk '{print "\n\t "  NR $2"\t"$4 "\t" $7}' | sed -e 's/(/ --- /g' -e 's/)/\t==>/g' >>$TEST/scan
		arp -an | sed '/<incomplete>/d' | grep ')te' | awk '{print "\n\t "  NR $2"\t"$3 "\t" $4}' | sed -e 's/(/ --- /g' -e 's/)te/\t==>/g' >>$TEST/scan
		clear; echo -e "\n\t\t\t  $blue  Ağda Bulunan Cihazlar$son\n\n\n$magenta\tSıra\tIP Adresi \t\t  Donanım Adresi \tAygıt $son"; cat $TEST/scan
		if [[ $CHZE = 'e' ]]; then echo -e "\n\n$blue***************** tarama işlemi kablolu bağlantı ile yapıldı ************$son"; else echo -e "\n\n$blue**************** tarama işlemi kablosuz bağlantı ile yapıldı *************$son"; fi
		echo -ne "\n\n\n $red [ Y ]$white Yenile \t $red [ B ]$white Cihaza Bağlan \t$red[ A ]$white Ana Seçenekler\t $red[ C ]$white Çıkış..$son\n\n "
		read ybac; case $ybac in 
			[yY] ) _tarama ;; [bB] ) echo -e "\n\t$yellow Bağlanmak istediğiniz cihazın --sıra sayısını-- girin$son\n"; _tarayici
		read -p "" sy ; sm="$sy --"
		 ADRS=$(cat $TEST/scan | grep -i "$sm" | awk '{print $3}'); $TRYC $ADRS &>/dev/null; _tarama ;; [aA] ) _baglanti_bilgilerim ;; [cC] ) clear; exit ;; esac
		}
		if [[ ($CHZS -ge '1') && (($WUG = 'w') || ($EUG = 'e')) ]]; then _tarama
		 else clear; echo -e "\n\n $red Bu işlemi yapabilmeniz için etkin bir ağa bağlı olmanız gerekiyor. \n\n $yellow Ana menüye dönülecek..$son\n\n"
		 sleep 4; clear; _baglanti_bilgilerim; fi 
		;;
        [yY] ) clear; sleep .5; _baglanti_bilgilerim
            ;;
        [cC] ) clear; exit
            ;;
esac
}

_baglanti_cacik () {
echo -e "\n\t $red AĞA BAĞLI HİÇBİR AYGIT BULUNAMADI !!!$son\n"
CHZ=$(ifconfig -s | grep 'BMRU' | awk '{print $1}')
AP=$(iwconfig $CHZ | grep 'Access Point' | awk '{print $4}')
if [[ $AP = Not-Associated ]]; then echo -e "\n$yellow Kablosuz aygıt kapalı, etkinleştirerek tekrar deneyin$son\n\n"; fi
}
_fping_kr () {
	clear; echo -e "\n\n $white Uygulamanın çalışabilmesi için,\n\n $cyan fping, bc$white ve$cyan ethtool$white paketinin kurulu olması gerekiyor.\n\n  Kurulum otomatik olarak başlayacak.. Bekleyin.! \n\n  İptal etmek için, şifre sorgusunda CTRL + C tuşunu kullanabilirsiniz$son\n"; sleep 3; clear
	DGTM=$(cat /etc/os-release | grep '^ID=' | cut -c4-10)
	if [[ $DGTM = 'arch' ]]; then sudo pacman -Sy fping bc ethtool --noconfirm ; sleep 2; clear
	elif  [[ $DGTM = 'ubuntu' ]]; then sudo apt install fping bc; sleep 2; clear
	elif  [[ $DGTM = 'manjaro' ]]; then sudo pacman -Sy fping bc ethtool --noconfirm; sleep 2; clear
	else echo -e "\n\n$red Kurulum bölümü, kullandığınız dağıtım için ilgili yönergeye sahip değil. :(  \n\n$cyan fping $red uygulamasını dağıtmınıza uygun olarak elle kurmayı deneyin.! $son\n"; sleep 10; fi; clear
	if [ -x /usr/bin/fping ] && [ -x /usr/bin/bc ] && [[ ((-x /usr/bin/ethtool) || (-x /sbin/ethtool)) ]]; then _baglanti_bilgilerim; else clear; echo -e "\n\n $red Kurulum aşaması tamamlanamadı. Eksik paketleriniz var. \n\n Paketleri elle kurmayı deneyin ve daha sonra tekrar çalıştırın$son\n\n"; sleep 2
	exit; fi
	}
if [ -x /usr/bin/fping ] && [ -x /usr/bin/bc ] && [[ ((-x /usr/bin/ethtool) || (-x /sbin/ethtool)) ]]; then echo ""; else _fping_kr; fi
BMR=$(ifconfig -s | awk '/BMU|BMRU/{print $1}' | awk 'END {print NR}')
if [[ $BMR -ge '1' ]]; then _baglanti_bilgilerim; else _baglanti_cacik; fi
}
ag_durumu
