#!/bin/bash
#########################################################################################################################
#                                                                                                                       #
# $$$$$$$\                      $$\           $$\   $$\            $$\                                       $$\        #
# $$  __$$\                     \__|          $$$\  $$ |           $$ |                                      $$ |       #
# $$ |  $$ | $$$$$$\   $$$$$$$\ $$\  $$$$$$$\ $$$$\ $$ | $$$$$$\ $$$$$$\   $$\  $$\  $$\  $$$$$$\   $$$$$$\  $$ |  $$\  #
# $$$$$$$\ | \____$$\ $$  _____|$$ |$$  _____|$$ $$\$$ |$$  __$$\\_$$  _|  $$ | $$ | $$ |$$  __$$\ $$  __$$\ $$ | $$  | #
# $$  __$$\  $$$$$$$ |\$$$$$$\  $$ |$$ /      $$ \$$$$ |$$$$$$$$ | $$ |    $$ | $$ | $$ |$$ /  $$ |$$ |  \__|$$$$$$  /  #
# $$ |  $$ |$$  __$$ | \____$$\ $$ |$$ |      $$ |\$$$ |$$   ____| $$ |$$\ $$ | $$ | $$ |$$ |  $$ |$$ |      $$  _$$<   #
# $$$$$$$  |\$$$$$$$ |$$$$$$$  |$$ |\$$$$$$$\ $$ | \$$ |\$$$$$$$\  \$$$$  |\$$$$$\$$$$  |\$$$$$$  |$$ |      $$ | \$$\  #
# \_______/  \_______|\_______/ \__| \_______|\__|  \__| \_______|  \____/  \_____\____/  \______/ \__|      \__|  \__| #
#                                                                                                                       #
# Original Version: https://github.com/agscript/ag-yonetimi                                                             #
#                                                                                                                       #
#########################################################################################################################

export LC_ALL=C #make output in English eg for later use with "du | grep"

#Enabled 1 / Disabled 0 - Auto change language feature - Default value 1
auto_change_language=1

#Language vars Change this line to select another default language. Select one from available values in array
language="turkish"
declare -A lang_association=(
                            ["en"]="english"
                            ["tr"]="turkish"
       )
#Colors vars
magenta_color="\033[1;35m"
white_color="\033[1;97m"
green_color="\033[1;32m"
red_color="\033[1;31m"
red_color_slim="\033[0;031m"
blue_color="\033[1;34m"
cyan_color="\033[1;36m"
brown_color="\033[0;33m"
yellow_color="\033[1;33m"
pink_color="\033[1;35m"
normal_color="\e[1;0m"

main() {
	clear
	echo
	clear

language_strings() {
        declare -gA g_texts
        g_texts["english",0]="${yellow_color}Enter Address: ${normal_color}"
        g_texts["turkish",0]="${yellow_color}Adresi Girin: ${normal_color}"
        g_texts["english",1]="Ping Test Completed. ${green_color}Connected${normal_color}"
        g_texts["turkish",1]="Ping Testi Tamamlandı. ${green_color}Bağlantı Var${normal_color}"
        g_texts["english",2]="Loading... Wait !..."
        g_texts["turkish",2]="Bilgiler alınıyor.. Bekleyin !..."
        g_texts["english",3]="connect to adress"
        g_texts["turkish",3]="adresine bağlanın"
        g_texts["english",4]="Data exchange is provided"
        g_texts["turkish",4]="Veri Akışı Var"
        g_texts["english",5]="Internet service is provided"
        g_texts["turkish",5]="Net Erişimi Var"
        g_texts["english",6]="Sequence"
        g_texts["turkish",6]="Sıra\t"
        g_texts["english",7]="Scanning was performed with wifi"
        g_texts["turkish",7]="tarama işlemi kablosuz bağlantı ile yapıldı"
        g_texts["english",8]="Scanning was performed with wired"
        g_texts["turkish",8]="Tarama işlemi kablolu bağlantı ile yapıldı"
        g_texts["english",9]="Found Network Devices"
        g_texts["turkish",9]="Ağda Bulunan Cihazlar"
        g_texts["english",10]="Device: "
        g_texts["turkish",10]="Aygıt: "
        g_texts["english",11]="Driver: "
        g_texts["turkish",11]="Sürücü: "
        g_texts["english",12]="Connection:"
        g_texts["turkish",12]="Bağlantı:"
        g_texts["english",13]="Version:"
        g_texts["turkish",13]="Sürüm:"
        g_texts["english",14]="Signal Level:"
        g_texts["turkish",14]="Sinyal Seviyesi:"
        g_texts["english",15]="Channel:"
        g_texts["turkish",15]="Kanal:"
        g_texts["english",16]="Transfer Speed:"
        g_texts["turkish",16]="Aktarım Hızı:"
        g_texts["english",17]="HW Address:"
        g_texts["turkish",17]="Donanım Adresi:"
        g_texts["english",18]="NetMask:"
        g_texts["turkish",18]="Ağ-Maskesi:"
        g_texts["english",19]="Modem-IP"
        g_texts["turkish",19]="Modem-İP:"
        g_texts["english",20]="ISP-IP:"
        g_texts["turkish",20]="ISS-İP:"
        g_texts["english",21]="Signal Quality:"
        g_texts["turkish",21]="Sinyal Kalitesi:"
        g_texts["english",22]="Choose one from the list"
        g_texts["turkish",22]="Bağlanmak istediğiniz cihazın --sıra sayısını-- girin"
        g_texts["english",23]="Available Wireless Networks"
        g_texts["turkish",23]="Kullanılabilir Kablosuz Ağlar"
        g_texts["english",24]="General Information"
        g_texts["turkish",24]="Genel Bilgiler"
        g_texts["english",25]="Internet Access Details"
        g_texts["turkish",25]="İnternet Bağlantı Ayrıntıları"
        g_texts["english",26]="Wired Access Details"
        g_texts["turkish",26]="Kablolu Bağlantı Ayrıntıları"
        g_texts["english",27]="Wireless Access Details"
        g_texts["turkish",27]="Kablosuz Bağlantı Ayrıntıları"
        g_texts["english",28]="Device opening, please wait ..."
        g_texts["turkish",28]="Aygıt açılıyor bekleyin ..."
        g_texts["english",29]="Open and refresh the writing device"
        g_texts["turkish",29]="Kablolu aygıtı aç ve yenile"
        g_texts["english",30]="Getaway"
        g_texts["turkish",30]="Ağ Geçidi"
        g_texts["english",31]="IP Address"
        g_texts["turkish",31]="İP Adresi"
        g_texts["english",32]="Connection Speed:"
        g_texts["turkish",32]="Bağlantı Hızı:"
        g_texts["english",33]="Cable"
        g_texts["turkish",33]="Kablo"
        g_texts["english",34]="Connected"
        g_texts["turkish",34]="Bağlı"
        g_texts["english",35]="Welcome"
        g_texts["turkish",35]="Hoş Geldiniz"
        g_texts["english",36]="${yellow_color}Enter the passphrase for ${red_color}$ITEM: ${normal_color}"
        g_texts["turkish",36]="${red_color}$ITEM ${yellow_color}için Parolayı girin: ${normal_color}"

        declare -gA b_texts
        b_texts["english",0]="Ping Process"
        b_texts["turkish",0]="Ping İşlemi"
        b_texts["english",1]="Modem Interface"
        b_texts["turkish",1]="Modem arayüzü"
        b_texts["english",2]="Page Reflesh"
        b_texts["turkish",2]="Sayfa Yenile"
        b_texts["english",3]="Wireless Networks"
        b_texts["turkish",3]="Kablosuz Ağlar"
        b_texts["english",4]="IP Scan"
        b_texts["turkish",4]="İP Tarama"
        b_texts["english",5]="Cancel"
        b_texts["turkish",5]="Çıkış"
        b_texts["english",6]="ReScan"
        b_texts["turkish",6]="Yeniden tara"
        b_texts["english",7]="Connect to"
        b_texts["turkish",7]="Bağlan"
        b_texts["english",8]="Main Options"
        b_texts["turkish",8]="Ana Seçenekler"
        b_texts["english",9]="Details"
        b_texts["turkish",9]="Ayrıntılar"
        b_texts["english",10]="New Address"
        b_texts["turkish",10]="Yeni Adres"
        b_texts["english",11]="Reflesh"
        b_texts["turkish",11]="Yenile"
        b_texts["english",12]="Connect to device"
        b_texts["turkish",12]="Cihaza Bağlan"
        b_texts["english",13]="Connect to WIFI networks\n"
        b_texts["turkish",13]="Kablosuz ağlara bağlan\n"
        b_texts["english",14]="No available wifi connection!\n"
        b_texts["turkish",14]="Kablosuz bağlantı bulunamadı!\n"
	b_texts["english",15]="Choose wifi connection or 'b' to back!\n"
	b_texts["turkish",15]="Kablosuz bağlantısını seçin veya 'b' ile geri!\n"
        b_texts["english",16]="wpa_supplicant running, sleeping for "
        b_texts["turkish",16]="wpa_supplicant çalışıyor, lütfen bekleyiniz... "
	b_texts["english",17]="OK"
	b_texts["turkish",17]="TAMAM"
	b_texts["english",18]="NO!"
	b_texts["turkish",18]="HAYIR!"
	b_texts["english",19]="Root Password: "
	b_texts["turkish",19]="Root Parolası: "

        declare -A err
        err["english",0]="NO DEVICE FOUND !!!\n"
        err["turkish",0]="AĞA BAĞLI HİÇBİR AYGIT BULUNAMADI !!!\n"
        err["english",1]="No Browser Found..."
        err["turkish",1]="Uygun Tarayıcı Bulunamadı..."
        err["english",2]="If you can scan or network hardware or wireless receiver is \n supposed to be always be open!"
        err["turkish",2]="Ağ taraması yapabilmeniz için kablosuz alıcınızın olması veya\n kapalı ise donanımın açık olması gerekiyor!"
        err["english",3]="Computer is not connected to any medem.\n ${yellow_color}will return to the main menu...${normal_color}"
        err["turkish",3]="Bilgisayarınız herhangi bir modeme bağlı değil.\n ${yellow_color} Ana menüye dönülecek...${normal_color}"
        err["english",4]="You need to be connected to a valid network, so you can't make this process\n will return to the main menu..."
        err["turkish",4]="Bu işlemi yapabilmeniz için etkin bir ağa bağlı olmanız gerekiyor.\n Ana menüye dönülecek..."
        err["english",5]="Wireless device off, turn it on before trying to connect any devices"
        err["turkish",5]="Kablosuz aygıt kapalı, etkinleştirerek tekrar deneyin"
        err["english",6]="To run the application, ${cyan_color} fping, bc ,hwinfo, curl ${white_color} and ${cyan_color} packages needs to be installed.\n The installation will start automatically ... Wait !\nIf you want to cancel, you can use CTRL + C ${normal_color}"
        err["turkish",6]="Uygulamanın çalışabilmesi için, ${cyan_color} fping, bc, hwinfo, curl ${white_color} ve ${cyan_color} ethtool  paketinin kurulu olması gerekiyor.\nKurulum otomatik olarak başlayacak.. Bekleyin.! \nİptal etmek için, şifre sorgusunda CTRL + C tuşunu kullanabilirsiniz${normal_color}"
        err["english",7]="The package installation process is not supported for the distribution you use. :(\n Try to manually install packages"
        err["turkish",7]="Kurulum bölümü, kullandığınız dağıtım için ilgili yönergeye sahip değil. :(\nfping uygulamasını dağıtmınıza uygun olarak elle kurmayı deneyin.!"
        err["english",8]="Setup could not be completed. Some packages are missing.\nTry installing packages manually and run again "
        err["turkish",8]="Kurulum aşaması tamamlanamadı. Eksik paketleriniz var.\nPaketleri elle kurmayı deneyin ve daha sonra tekrar çalıştırın."
        err["english",9]="Your gateway is not supported ip range. Will return ti the previous menu ..."
        err["turkish",9]="Ağ geçidiniz öngörülen ip aralığında değil. Önceki menüye dönülecek..."
        err["english",10]="Negative Ping Request! Connection Fails"
        err["turkish",10]="Ping Testi Olumsuz! Bağlantı Kurulamadı"
        err["english",11]="No Internet Access"
        err["turkish",11]="Net Data Exchange"
        err["english",12]="No translation yet"
        err["turkish",12]="Veri Akışı Yok"
        err["english",13]="You need to be connected to a valid network, so you can't make this process.\n${yellow_color}will return to the main menu ..."
        err["turkish",13]="Bu işlemi yapabilmeniz için etkin bir ağa bağlı olmanız gerekiyor.\n${yellow_color}Ana menüye dönülecek..."
	err["english",14]="Unknown"
	err["turkish",14]="Bilinmiyor"
	err["english",15]="Do not run as Root!"
	err["turkish",15]="Root olarak çalıstırmayınız!"
        err["english",16]="No translation yet"
	err["turkish",16]="\n\n${red_color}Uyarı: ${yellow_color}Hatalı parola girildiğinde ${cyan_color}'d'${yellow_color} tuşuna basınız!\n${normal_color}"

        case "$3" in
                "yellow")
                        interrupt_checkpoint ${2} ${3}
                        echo_yellow "${err[$1,$2]}"
                ;;
                "blue")
                        echo_blue "${err[$1,$2]}"
                ;;
                "red")
                        echo_red "${err[$1,$2]}"
                ;;
                "green")
                        if [ ${2} -ne ${abort_question} ]; then
                                interrupt_checkpoint ${2} ${3}
                        fi
                        echo_green "${err[$1,$2]}"
                ;;
                "pink")
                        echo_pink "${err[$1,$2]}"
                ;;
                "title")
                        generate_dynamic_line "${g_texts[$1,$2]}" "title"
                ;;
                "read")
                        interrupt_checkpoint ${2} ${3}
                        read  -p "$(echo -e ${g_texts[$1,$2]})" $3
                ;;
                *)
                        if [ -z "$3" ]; then
                                last_echo "${err[$1,$2]}" ${normal_color}
                        fi
                ;;
        esac
}
under_construction_message() {

        local var_uc="${under_constructionvar^}"
        echo
        echo_yellow "$var_uc..."
        language_strings ${language} 2 "read"
}

last_echo() {

        check_pending_of_translation "$1" ${2}
        if [ "$?" != "0" ]; then
                echo -e ${2}"$text"${normal_color}
        else
                echo -e ${2}"$*"${normal_color}
        fi
}

echo_green() {

        last_echo "$1" ${green_color}
}

echo_blue() {

        last_echo "$1" ${blue_color}
}
echo_yellow() {

        last_echo "$1" ${yellow_color}
}

echo_red() {

        last_echo "$1" ${red_color}
}

echo_red_slim() {

        last_echo "$1" ${red_color_slim}
}

echo_pink() {

        last_echo "$1" ${pink_color}
}

echo_cyan() {

        last_echo "$1" ${cyan_color}
}

echo_brown() {

        last_echo "$1" ${brown_color}
}
autodetect_language() {

        [[ $(locale | grep LANG) =~ ^(.*)=\"?([a-zA-Z]+)_(.*)$ ]] && lang="${BASH_REMATCH[2]}"

        for lgkey in "${!lang_association[@]}"; do
                if [[ "$lang" = "$lgkey" ]] && [[ "$language" != ${lang_association["$lgkey"]} ]]; then
                        autochanged_language=1
                        language=${lang_association["$lgkey"]}
                        break
                fi
        done
}
check_pending_of_translation() {

        if [[ "$1" =~ ^$escaped_pending_of_translation([[:space:]])(.*)$ ]]; then
                text=${cyan_color}"$pending_of_translation "${2}"${BASH_REMATCH[2]}"
                return 1
        elif [[ "$1" =~ ^$escaped_hintvar[[:space:]](\\033\[[0-9];[0-9]{1,2}m)?($escaped_pending_of_translation)[[:space:]](.*) ]]; then
                text=${cyan_color}"$pending_of_translation "${brown_color}"$hintvar "${pink_color}"${BASH_REMATCH[3]}"
                return 1
        elif [[ "$1" =~ ^(\*+)[[:space:]]$escaped_pending_of_translation[[:space:]]([^\*]+)(\*+)$ ]]; then
                text=${2}"${BASH_REMATCH[1]}"${cyan_color}" $pending_of_translation "${2}"${BASH_REMATCH[2]}${BASH_REMATCH[3]}"
                return 1
        elif [[ "$1" =~ ^(\-+)[[:space:]]\($escaped_pending_of_translation[[:space:]]([^\-]+)(\-+)$ ]]; then
                text=${2}"${BASH_REMATCH[1]} ("${cyan_color}"$pending_of_translation "${2}"${BASH_REMATCH[2]}${BASH_REMATCH[3]}"
                return 1
        fi

        return 0
}
generate_dynamic_line() {

        local type=${2}
        if [ "$type" = "title" ]; then
		ncharstitle=$(tput cols)
                titlechar="*"
        elif [ "$type" = "separator" ]; then
                ncharstitle=$(tput cols)
                titlechar="-"
        fi

        titletext=${1}
        titlelength=${#titletext}
        finaltitle=""

        for ((i=2; i < ($ncharstitle/2 - $titlelength+($titlelength/2)); i++)); do
                finaltitle="$finaltitle$titlechar"
        done

        if [ "$type" = "title" ]; then
                finaltitle="$finaltitle $titletext "
        elif [ "$type" = "separator" ]; then
                finaltitle="$finaltitle ($titletext) "
        fi

        for ((i=0; i < ($ncharstitle/2 - $titlelength+($titlelength/2)); i++)); do
                finaltitle="$finaltitle$titlechar"
        done

        if [ $(($titlelength % 2)) -gt 0 ]; then
                finaltitle+="$titlechar"
        fi

        if [ "$type" = "title" ]; then
                echo_red "$finaltitle"
        elif [ "$type" = "separator" ]; then
                echo_blue "$finaltitle"
        fi
}
interrupt_checkpoint() {

	if [[ -z "$last_buffered_type1" ]]; then
		last_buffered_message1=${1}
		last_buffered_message2=${1}
		last_buffered_type1=${2}
		last_buffered_type2=${2}
	else
		if [[ ${1} -ne ${resume_message} ]]; then
			last_buffered_message2=${last_buffered_message1}
			last_buffered_message1=${1}
			last_buffered_type2=${last_buffered_type1}
			last_buffered_type1=${2}
		fi
	fi
}
root_control() {
	if [ $(id -u ) -eq 0 ];then
		language_strings ${language} 15 "red"
                rm -r /tmp/agtest	
		exit 1
	fi
}
print_intro() {
printf "%*s" $[((`tput cols`/2-45))];echo -e ${yellow_color}  "__________                .__        _______          __                       __"
printf "%*s" $[((`tput cols`/2-45))];sleep 0.10 && echo -e " \______   \______    _____|__| ____  \      \   _____/  |___  _  _____________|  | __"
printf "%*s" $[((`tput cols`/2-45))];sleep 0.10 && echo -e "   |    |  _/\__  \  /  ___/  |/ ___\ /   |   \_/ __ \   __\ \/ \/ /  _ \_  __ \  |/ /"
printf "%*s" $[((`tput cols`/2-45))];sleep 0.10 && echo -e "   |    |   \ / __ \_\___ \|  \  \___/    |    \  ___/|  |  \     (  <_> )  | \/    < "
printf "%*s" $[((`tput cols`/2-45))];sleep 0.10 && echo -e "   |______  /(____  /____  >__|\___  >____|__  /\___  >__|   \/\_/ \____/|__|  |__|_ \\"
printf "%*s" $[((`tput cols`/2-45))];sleep 0.10 && echo -e "          \/      \/     \/        \/        \/     \/                              \/"${normal_color}
	echo
	sleep 1
}
pfile_clear() {
PFILE="/tmp/passw"
    if [ -f $PFILE ];then
        rm $PFILE
    fi
}

connect_info() {
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
	clear

if [ ${auto_change_language} -eq 1 ];then
               	autodetect_language
fi
    root_control
    language_strings ${language} 35 "title"
    print_intro
    printf "%*s" $[((`tput cols`/2-9))]; echo -e "${green_color}${g_texts[$language,24]}\n\n"

wifi() {
        YER=$(iw dev $KCHZ1 link | awk '/SSID/{print $2}')
        DADR=$(iw dev $KCHZ1 link | awk '/Connected/{print $3}')
        KALITE=$(iwconfig $KCHZ1 | awk '/Link Quality/{print $2}' | sed 's/Quality=//g')
        SSVY=$(iwconfig $KCHZ1 | awk '/Signal level/{print $4,$5}'| sed 's/level=//')
        KANAL=$(iwlist $KCHZ1 channel | awk '/Current/{print $5}' | sed 's/)//')
        FREK=$(iwlist $KCHZ1 channel | awk '/Current/{print $2}' | cut -c11-18)
        VRHZ=$(iwlist $KCHZ1 bitrate | awk '/Current/{print $3,$4}' | cut -c6-15)
        WSRC=$(ethtool -i $KCHZ1 | awk '/driver/{print $2}')
        VERS=$(ethtool -i $KCHZ1 | awk '/^version/{print $2}')
        PCIP1=$(ifconfig $KCHZ1 | awk '/inet/{print $2}' | sed -n -e 's/addr://g' -e 1p)
        MacA=$(ifconfig $KCHZ1 | awk '/ether/{print $1}')

    if [[ $MacA = 'ether' ]]; then
        MASK=$(ifconfig $KCHZ1 | awk '/netmask/{print $4}')
    else
        MASK=$(ifconfig $KCHZ1 | awk '/Mask/{print $4}' | sed -n -e 's/Mask://g' -e 1p)
    fi

ping -q -w1 -c1 $PCIP1 &>$TEST/ipkont
if [ $? -eq 0 ];then
    SNC=$(echo -en "${green_color}${g_texts[$language,4]}${normal_color}")
else
    SNC=$(echo -en "${green_color}${err[$language,11]}${normal_color}")
fi
printf "%*s" $[((`tput cols`/2-45))];echo -e "${red_color}[ W ] ${blue_color}${b_texts[$language,9]}${magenta_color} Wifi:${yellow_color} $YER ${magenta_color} IP:${yellow_color} $PCIP1${normal_color} = $SNC \n"
}
cable() {
	ethtool $KCHZ2 >$TEST/etht
	ethtool -i $KCHZ2 >$TEST/etbl
	if [[ -x /usr/bin/nmcli ]]; then
	EDADR=$(nmcli dev show $KCHZ2 | awk '/HWADDR/{print $2}')
	else
	EDADR=$(ifconfig $KCHZ2 | awk '/ether/{print $2}')
	fi

	EAGG=$(route -n | awk '/UG/{ print $2}' | sed -n 1p)
	ESRC=$(cat $TEST/etbl | awk '/driver/{print $2}')
	EVERS=$(cat $TEST/etbl | awk '/^version/{print $2}')
	BAGD=$(cat $TEST/etht | grep 'Link detected' | awk '{print $3}')
	EVRHZ=$(cat $TEST/etht | awk '/Speed/{print $2}')
	PORTS=$(cat $TEST/etht | awk '/Supported link modes:/{f=1;next} /Supported pause frame/{f=0} f' | tail -n1 -c16 | sed -e 's/^[[:space:]]*//' -e 's/\//:/') 
	PCIP2=$(ifconfig $KCHZ2 | awk '/inet/{print $2}' | sed -n -e 's/addr://g' -e 1p)
	MacA=$(ifconfig $KCHZ2 | awk '/ether/{print $1}')

if [[ $BAGD = 'yes' ]]; then
    EBAG='Var'
else
    EBAG='Yok'
fi

if [[ $MacA = 'ether' ]]; then
	MAD=$(ifconfig $KCHZ2 | awk '/ether/{print $2}' | sed -n 1p)
	MASK=$(ifconfig $KCHZ2 | awk '/netmask/{print $4}')
else
	MAD=$(ifconfig $KCHZ2 | awk '/HWaddr/{print $5}')
	MASK=$(ifconfig $KCHZ1 | awk '/Mask/{print $4}' | sed -n -e 's/Mask://g' -e 1p)
fi

ping -q -w1 -c1 $PCIP2 &>$TEST/kakont
if [ $? -eq 0 ];then
    SNB=$(echo -e "${green_color}${g_texts[$language,4]}${normal_color}")
else
    SNB=$(echo -e "${green_color}${err[$language,12]}${normal_color}")
fi
printf "%*s" $[((`tput cols`/2-40))];echo -e "\n${red_color}[ E ] ${blue_color}${b_texts[$language,9]} ${magenta_color}${g_texts[$language,33]}${yellow_color}${g_texts[$lamguage,34]} ${magenta_color} IP:${yellow_color} $PCIP2${normal_color} = $SNB \n"
}
modemkont() {
    MODEMIP=$(route -n | awk '/UG/{ print $2}' | sed -n 1p)
    if [[ (($EUG = 'e') && ($CHZA = 'e')) ]]; then
        TLIP=$(curl --interface "$KCHZ2" -s http://ipecho.net/plain; &>/dev/null)
    else
        TLIP=$(curl -s http://ipecho.net/plain; &>/dev/null)
    fi

ping -q -w1 -c1 www.google.com &>$TEST/netkont
if [ $? -eq 0 ];then
    SNI=$(echo -e "${green_color}${g_texts[$language,5]}${normal_color}")
else
	SNI=$(language_strings ${language} 11 "red")
fi
	printf "%*s" $[((`tput cols`/2-45))];echo -ne "${red_color}[ N ] ${blue_color}${b_texts[$language,9]}${magenta_color} ${g_texts[$language,20]}${yellow_color} $TLIP${normal_color} = $SNI\n\n"
}

cabtest() {
	KART=$(hwinfo --netcard | awk '/Driver:/{print $2}' | head -n1 | sed 's/"//g')
	KDRM=$(dmesg | grep $KART | tail -n1 -c5)
	UGS=$(cat /proc/net/dev | grep '^e' | awk -F: '{print $1}')

	if [[ (($KDRM = 'down') && ($CHZE = 'w') && ($EUG = 'e')) ]]; then
    		ifconfig $UGS down
	fi
		ETHT=$(ip link show | grep LOWER_UP | awk '{print $2}'| grep 'e' | cut -c1)
	if [[ (($CHZE = 'w') && ($EUG != 'e') && ($KDRM = 'down')) ]]; then
    		echo -ne "\n${red_color}[ A ] ${blue_color}${g_texts[$language,29]}${normal_color}\n\n"
	fi
}

	if [[ (($CHZS -eq '1') && ($WUG = 'w')) ]]; then
	KCHZ1=$(ifconfig -s | awk '/BMRU/{print $1}' | sed -n 1p)
        cabtest
        wifi
 	elif [[ (($CHZS -eq '1') && ($EUG = 'e')) ]]; then
	KCHZ2=$(ifconfig -s | awk '/BMRU/{print $1}' | sed -n 1p)
	cable
    	fi
	if [[ $CHZS -eq '2' ]]; then
        if [[ (( $WUG = 'w' ) && ( $EUG = 'e' )) ]]; then
		KCHZ1=$(ifconfig -s | awk '/BMRU/{print $1}' | sed -n -e 2p)
      		KCHZ2=$(ifconfig -s | awk '/BMRU/{print $1}' | sed -n 1p)
                cable
                wifi
	elif [[ (( $WUG = 'w' ) && ( $EUG != 'e' )) ]]; then
		KCHZ1=$(ifconfig -s | awk '/BMRU/{print $1}' | sed -n -e 2p)
                wifi
	elif [[ (( $EUG != 'e' ) && ( $WUG = 'w' )) ]]; then
		KCHZ2=$(ifconfig -s | awk '/BMRU/{print $1}' | sed -n -e 1p)
             cable
        fi
    fi

if [[ ($CHZS -ge '1') && (($WUG = 'w') || ($EUG = 'e')) ]]; then
    modemkont
else
	language_strings ${language} 0 "red"
fi

	language_strings ${language} "" "title"
	echo -en "\n\t${red_color}[ P ] ${white_color}${b_texts[$language,0]}\t${red_color}[ K ] ${white_color}${b_texts[$language,3]}\t${red_color}[ T ] ${white_color}${b_texts[$language,4]}\n\n" \
	"\t${red_color}[ M ] ${white_color}${b_texts[$language,1]}\t${red_color}[ Y ] ${white_color}${b_texts[$language,2]}\t${red_color}[ C ] ${white_color}${b_texts[$language,5]}${normal_color}\n\n"

WebBrowser() {
	if [[ $(which google-chrome-stable 2>/dev/null) != "" ]];then
		TRYC='google-chrome-stable'
    	elif [[ $(which chromium 2>/dev/null) != "" ]];then
		TRYC='chromium'
	elif [[ $(which firefox 2>/dev/null) != "" ]];then
		TRYC='firefox'
        elif [[ $(which opera 2>/dev/null) != "" ]];then
		TRYC='opera'
        else
        clear
        language_strings ${language} 1 "red"
        sleep 3;
        connect_info
   fi
}

Arch_DNS() {
	dnss=`cat /etc/resolv.conf | grep -v '^#' | grep nameserver | awk '{print $2}'`
	option_counter=0
	for i in ${dnss}; do
		option_counter=$[option_counter + 1]
		if [ ${#option_counter} -eq 1 ]; then
			spaceiface=" "
		else
			spaceiface="  "
		fi
		echo -ne " ${magenta_color}DNS$option_counter:$spaceiface${yellow_color}$i"
	done
	echo -e "\n"
}
ARDN=$(cat /etc/resolv.conf|grep nameserver|awk 'END{print NR}')

read apkhmtwenyc
case $apkhmtwenyc in
	[aA] )
	clear
		language_strings ${language} 30 "yellow"
		ifconfig $UGS up ; rm /tmp/ekp 2>/dev/null
		systemctl restart NetworkManager.service
	sleep 8
		connect_info
		;;
	[wW] )
		wfdetay () {
		clear
        	printf "%*s" $[((`tput cols`/2-9))]; echo -e "${green_color}${g_texts[$language,27]}\n"
		wifi_chipset
		echo -e "\n${magenta_color} ${g_texts[$language,11]}${yellow_color}$WSRC ${magenta_color}" \
                        "${g_texts[$language,13]} ${yellow_color}$VERS ${magenta_color}${g_texts[$language,17]} ${yellow_color}$DADR\n\n${magenta_color}" \
                        "${g_texts[$language,12]} ${yellow_color}$YER ${magenta_color} ${g_texts[$language,14]} ${yellow_color}$SSVY ${magenta_color}" \
                        "${g_texts[$language,21]} ${yellow_color}$KALITE\n\n${magenta_color} Frekans: ${yellow_color}$FREK GHz ${magenta_color}" \
                        "${g_texts[$language,15]} ${yellow_color}$KANAL ${magenta_color}${g_texts[$language,16]} ${yellow_color}$VRHZ ${magenta_color} IP: ${yellow_color}$PCIP1 ${normal_color}\n"

wdnsaddr() {

        wdnss=`nmcli dev show $KCHZ1 | awk '/IP4.DNS/{print $2}'`
        option_counter=0
        for i in ${wdnss}; do
                option_counter=$[option_counter + 1]
                if [ ${#option_counter} -eq 1 ]; then
                        spaceiface=" "
                else
                        spaceiface="  "
                fi
                echo -ne " ${magenta_color}DNS$option_counter:$spaceiface${yellow_color}$i"
        done
        echo -e "\n"
}
	if [[ -x /usr/bin/nmcli ]]; then
            wdnsaddr
        elif [[ "$ARDN" -ge '1' ]]; then
            Arch_DNS
          fi
	language_strings ${language} "" "title"
	echo -e  "\n\n\t${red_color}[ Y ] ${white_color}${b_texts[$language,11]}\t${red_color}[ A ] ${white_color}${b_texts[$language,8]}\t${red_color}[ C ] ${white_color}${b_texts[$language,5]}${normal_color}\n\n "

	read yac
        case $yac in
		[yY] )
			clear
                        wfdetay
                    	;;
                [aA] )
                    	connect_info
                    	;;
                [cC] )
                    	clear
			pfile_clear
                        exit
                    	;;
            	esac
	}
        wfdetay
	;;
[eE] )
	ethdetay () {
	clear
	printf "%*s" $[((`tput cols`/2-14))]; echo -e "${blue_color}${g_texts[$language,26]}"
	eth_chipset
	echo -en "${magenta_color}${g_texts[$language,11]} ${yellow_color} ${ESRC} ${magenta_color}" \
                 "${g_texts[$language,13]} ${yellow_color} ${EVERS} ${magenta_color}${g_texts[$language,17]} ${yellow_color} ${EDADR}\n\n\n${magenta_color}" \
                 "${g_texts[$language,12]} ${yellow_color} ${EBAG} ${magenta_color} Port: ${yellow_color} ${PORTS} ${magenta_color}${g_texts[$language,16]} ${yellow_color} ${EVRHZ}\n\n\n${magenta_color" \
                 "${g_texts[$language,30]} ${yellow_color} ${EAGG} $magenta_color} IP: ${yellow_color} ${PCIP2} ${normal_color}\n\n"

EDNSaddr() {
        ednss=`nmcli dev show $KCHZ2 | awk '/IP4.DNS/{print $2}'`
        option_counter=0
        for i in ${ednss}; do
                option_counter=$[option_counter + 1]
                if [ ${#option_counter} -eq 1 ]; then
                        spaceiface=" "
                else
                        spaceiface="  "
                fi
                echo -ne " ${magenta_color}DNS$option_counter:$spaceiface${yellow_color}$i"
        done
        echo -e "\n"
}
	if [[ -x /usr/bin/nmcli ]]; then
            EDNSaddr
        elif [[ "$ARDN" -ge '1' ]]; then
            Arch_DNS
          fi
	language_strings ${language} "" "title"
	echo -e "\t${red_color}[ Y ] ${white_color}${b_texts[$language,11]}\t${red_color}[ A ] ${white_color}${b_texts[$language,8]}\t${red_color}[ C ] ${white_color}${b_texts[$language,5]}${normal_color}\n\n "
	read yac
        case $yac in
		[yY] )
                    clear
                    ethdetay
                    ;;
                [aA] )
                    connect_info
                    ;;
                [cC] )
                    clear
	            pfile_clear
                    exit
                    ;;
            esac
		};
            ethdetay
		;;
        [nN] )
		netbil () {
		echo -e "\n\n${cyan_color}${g_texts[$language,2]}${normal_color}\n\n"
		TMP_PATH=/tmp/agtest/speedtest_data/
		TEST_TIME=5
		rm -rf $TMP_PATH && mkdir $TMP_PATH

	links=("http://client.cdn.gamigo.com/bp/eu/com/110a/BPClientSetup-2b.bin"
		"http://client.cdn.gamigo.com/bp/eu/com/110a/BPClientSetup-1b.bin"
		"http://client.cdn.gamigo.com/bp/eu/com/110a/BPClientSetup-1c.bin"
		"http://ftp.ntua.gr/pub/linux/ubuntu-releases-dvd/quantal/release/ubuntu-12.10-server-armhf+omap.img"
		"http://ftp.funet.fi/pub/Linux/INSTALL/Ubuntu/dvd-releases/releases/12.10/release/ubuntu-12.10-server-armhf+omap.img"
		"http://ftp.icm.edu.pl/pub/Linux/opensuse/distribution/13.2/iso/openSUSE-13.2-DVD-x86_64.iso")

	for link in ${links[*]}
	do
    		timeout $TEST_TIME wget -q -P $TMP_PATH $link &
	done
		wait
		total_bytes=$(du -c $TMP_PATH | grep total | awk '{print $1}')
		rm -rf $TMP_PATH
		speed=$(expr $total_bytes / $TEST_TIME)
		echo "Speed is $speed Kb/s"
		sonuc=$(echo "scale=2;$speed/106" | bc)
		clear

	printf "%*s" $[((`tput cols`/2-9))]; echo -e "${green_color}${g_texts[$language,25]}"
        echo -e "\n\n ${magenta_color}${g_texts[$language,18]}${yellow_color} $MASK\t ${magenta_color}${g_texts[$language,19]}${yellow_color} $MODEMIP${normal_color} \n\n${magenta_color}" \
                "${g_texts[$language,32]} ${yellow_color}$sonuc Mbps \t ${magenta_color}${g_texts[$language,20]}${yellow_color} $TLIP${normal_color}\n"
	language_strings ${language} "" "title"
	echo -e "\n\n\t${red_color}[ Y ] ${white_color}${b_texts[$language,11]}\t ${red_color}[ A ] ${white_color}${b_texts[$language,8]}\t${red_color}[ C ] ${white_color}${b_texts[$language,5]}${normal_color}\n"

	read yac
        case $yac in
		[yY] )
                    clear
                    netbil
                    ;;
                [aA] )
                    connect_info
                    ;;
                [cC] )
                    clear
                    pfile_clear
                    exit
                    ;;
            esac
	}
        clear
        netbil
        ;;
   [pP] )
      _ping() {
	_arayuz() {
		language_strings ${language} "" "title"
		echo -e "\n\t${red_color}[ Y ] ${white_color}${b_texts[$language,10]}\t${red_color}[ A ] ${white_color}${b_texts[$language,8]}\t${red_color}[ C ] ${white_color}${b_texts[$language,5]}${normal_color}\n" \
			"\n\t${red_color}[ B ] ${yellow_color}$read ${white_color}${g_texts[$language,3]}${normal_color}\n"
		read ybac
                case $ybac in

		[bB] )
                        WebBrowser
                        $TRYC $read &>/dev/null
                        clear
                        Options
                        ;;
		[yY] )
			Address
			;;
		[aA] )
                        connect_info
                        ;;
		[cC] )
                        clear
                        pfile_clear
                        exit
                        ;;
                esac
	}
Address() {
        clear;
       	printf "%*s" $[((`tput cols`/2-9))]; echo -e "${blue_color}${b_texts[$language,0]}${normal_color}"
	echo -e "\n"
	language_strings ${language} 0 "read"
        echo
	language_strings ${language} "" "title"
	echo
	ping -q -w1 -c1  $read
	if [[ $? -eq 0 ]]; then
	echo -e "\n\n\t${magenta_color} $read :${normal_color}${g_texts[$language,1]}${normal_color}\n"
	        _arayuz
	else
		echo -e "\n\n\t${magenta_color} $read :${normal_color}${err[$language,10]}${normal_color}\n"
                Options
        fi
}
Options() {
	language_strings ${language} "" "title"
	echo -e "\t${red_color}[ Y ] ${white_color}${b_texts[$language,10]}\t${red_color}[ A ] ${white_color}${b_texts[$language,8]}\t${red_color}[ C ] ${white_color}${b_texts[$language,5]}${normal_color}\n\n "
	read yac
	case $yac in
	    [yY] )
		Address
		;;
            [aA] )
                connect_info
                ;;
            [cC] )
                clear
		pfile_clear
                exit
                ;;
	esac
}
ping_check() {
clear
printf "%*s" $[((`tput cols`/2-9))]; echo -e "${blue_color}${b_texts[$language,0]}${normal_color}"
echo -e "\n"
language_strings ${language} 0 "read"
echo
language_strings ${language} "" "title"
echo
ping -q -w1 -c1 $read
if [[ $? -eq 0 ]]; then
	echo -e "\n\n\t${brown_color} $read :${normal_color}${g_texts[$language,1]}${normal_color}\n"
	_arayuz
else
	echo -e "\n\n\t${magenta_color} $read :${normal_color}${err[$language,10]}${normal_color}\n"
	Options
fi
}
	ping_check
   }
	if [[ ($CHZS -ge '1') && (($WUG = 'w') || ($EUG = 'e')) ]]; then
		_ping
	else
        	clear
        	language_strings ${language} 12 "red"
        	sleep 4
        	clear
        	connect_info
        fi
            ;;
        [kK] )
		wifiScan () {
			WK=$(ifconfig -s | awk '/BMU|BMRU/{print $1}' | grep 'w' | cut -c1)

        	_Network_Manager () {
	    		clear
        		WIFISIZE=`nmcli dev wifi | awk 'FNR <= 1'|sed -e 's/^/│/g' -e 's/$/│/g'`

        		printf "%*s" $[((`tput cols`/2-12))]; echo -e "${blue_color}${g_texts[$language,23]}${normal_color}"
        		printf "\n┌"
        	for ((i=6; i<${#WIFISIZE}; i++))
        	do
            		printf "─"
        	done
	        	printf "┐\n"
	        	echo "$WIFISIZE"
	        	printf "├"
        	for ((i=6; i<${#WIFISIZE}; i++))
		do
			printf "─"
		done
	        	printf "┤\n"
            		nmcli dev wifi |grep -v SSID| awk 'FNR <= 20'|sed -e 's/^/│/g' -e 's/$/│/g'
	        	printf "└"
                for ((i=6; i<${#WIFISIZE}; i++))
        	do
            		printf "─"
        	done
	        	printf "┘\n\n"
	}
		X_Manager () {
			clear
        		printf "%*s" $[((`tput cols`/2-12))]; echo -e "${blue_color}${g_texts[$language,23]}${normal_color}"
			WDEV=$(ip link|awk -F: '/wl/{print $2}')

			PFILE="/tmp/passw"

                        if [ -f $PFILE ];then
                        wifi_iw
                        else
                        language_strings ${language} 16
                        read -s -p "$(echo -e ${red_color}${b_texts[$language,19]}${normal_color})" passw
                        echo $passw > $PFILE
                        wifi_iw
                        fi
                }
		wifi_iw() {
			cat $PFILE |sudo -S iw dev $WDEV scan 2>/dev/null | gawk '$1 == "BSS" {
                                                MAC = $2
                                                wifi[MAC]["enc"] = "Open"
                                                }
                                                $1 == "SSID:" {
                                                wifi[MAC]["SSID"] = $2
                                                }
                                                $2 == "primary" {
                                                wifi[MAC]["channel"] = $4
                                                }
                                                $1 == "signal:" {
                                                wifi[MAC]["sig"] = $2 " " $3
                                                }
                                                $1 == "RSN:" {
                                                wifi[MAC]["enc"] = "WPA2"
                                                }
                                                $1 == "WPA:" {
                                                wifi[MAC]["enc"] = "WPA"
                                                }
                                                $1 == "WEP:" {
                                                wifi[MAC]["enc"] = "WEP"
                                                }
                                                END {
                                                printf "\n\t┌───────────────────────────────────────────────────────────────────────────┐\n"
                                                printf "\t│%s%42s%10s%17s  │\n","SSID","Channel","Signal","Encryption"
                                                printf "\t├───────────────────────────────────────────────────────────────────────────┤\n"
                                                for (w in wifi) {
                                                printf "\t│%-32s\t%s\t%13s\t%-12s│\n",wifi[w]["SSID"],wifi[w]["channel"],wifi[w]["sig"],wifi[w]["enc"]
                                                        }
                                                printf "\t└───────────────────────────────────────────────────────────────────────────┘\n"
                                        }'
			echo

		}
		if [[ (($WK = 'w') && ( -x /usr/bin/nmcli)) ]]; then
            		_Network_Manager
        	elif [[ $WK = 'w' ]]; then
            		X_Manager
		else
                	 clear
                	language_strings ${language} 2 "red"
             	fi
			language_strings ${language} "" "title"
        		echo -ne "\n\t${red_color}[ Y ] ${white_color}${b_texts[$language,6]}\t${red_color}[ B ] ${white_color}${b_texts[$language,7]}\t ${red_color}[ A ] ${white_color}${b_texts[$language,8]}\t${red_color}[ C ] ${white_color}${b_texts[$language,5]}$normal_color\n"
		read ybacd
		case $ybacd in
			[yY] )
                		clear
                		wifiScan
               		 ;;
			[bB] )
				clear
                                printf "%*s" $[((`tput cols`/2-14))]; echo -e "${blue_color}${b_texts[$language,13]}${normal_color}"
				pconf_control
	        		connect_info
           			;;
			[aA] )
                		connect_info
                		;;
            		[cC] )
                		clear
			        pfile_clear
                		exit
                		;;
			[dD] )
				clear
				pfile_clear
				wifiScan
				;;
            		esac
		}

        		clear
			wifiScan
            		;;
        	[mM] )
		    modem_arayuzu () {
		    WebBrowser
 		    $TRYC $MODEMIP &>/dev/null
		    connect_info
		}
		if [[ ($CHZS -ge '1') && (($WUG = 'w') || ($EUG = 'e')) ]]; then
            		modem_arayuzu
		else
             		clear
              		language_strings ${language} 3 "red"
            		sleep 3
         		clear
         		connect_info
        	fi
        		;;
		[tT] )
	    		Scan () {
	        		MIP=$(route -n | awk '/UG/{ print $2}' | sed -n -e 1p | cut -c1-2)
				if [[ $MIP = '19' ]]; then
        	        		IPARA=$(route -n | awk '/UG/{ print $2}' | sed -n 1p | cut -c1-9)
				elif [[ $MIP = '10' ]]; then
          	      			IPARA=$(route -n | awk '/UG/{ print $2}' | sed -n 1p | cut -c1-6)
				else
                	clear
                	language_strings ${language} 9 "red"
            		sleep 3
            		clear
                	connect_info
            	fi

		clear
        	echo -e "\n\n"
            	fping -c1 -g $IPARA.0/24
		rm $TEST/scan 2>/dev/null
		arp -an | sed '/<incomplete>/d' | grep ') at' | awk '{print "\n\t " NR $2"\t"$4 "\t" $7}' | sed -e 's/(/ \t---\t /g' -e 's/)/\t==>/g' >>$TEST/scan
		arp -an | sed '/<incomplete>/d' | grep ')te' | awk '{print "\n\t " NR $2"\t"$3 "\t" $4}' | sed -e 's/(/ \t---\t /g' -e 's/)te/\t==>/g' >>$TEST/scan
		clear
		printf "%*s" $[((`tput cols`/2-9))]; echo -e "${blue_color}${g_texts[$language,9]}${normal_color}\n"
            	echo -e "\n${magenta_color}\t${g_texts[$language,6]}\t${g_texts[$language,31]}\t\t${g_texts[$language,17]}\t\t${g_texts[$language,10]}$normal_color"
            	cat $TEST/scan
		if [[ $CHZE = 'e' ]]; then
			echo -e "\n\n\t\t\t${green_color}${g_texts[$language,8]}${normal_color}\n"
        	else
	        	echo -e "\n\n\t\t\t${green_color}${g_texts[$language,7]}${normal_color}\n"
        	fi
			language_strings ${language} "" "title"
		echo -ne "\n\t${red_color}[ Y ] ${white_color}${b_texts[$language,11]}\t${red_color}[ B ] ${white_color}${b_texts[$language,12]}\t${red_color}[ A ] ${white_color}${b_texts[$language,8]}\t${red_color}[ C ] ${white_color}${b_texts[$language,5]}${normal_color}\n\n "

	read ybac
        case $ybac in
		[yY] )
                	Scan
                	;;
            	[bB] )
			echo -e "${yellow_color}${g_texts[$language,22]}${normal_color}"
                	WebBrowser
			read -p "" sy ; sm="$sy --"
			ADRS=$(cat $TEST/scan | grep -i "$sm" | awk '{print $3}')
			$TRYC $ADRS &>/dev/null
	        	Scan
         		;;
            	[aA] )
                	connect_info
                	;;
            	[cC] )
                	clear
		        pfile_clear
                	exit
                	;;
            	esac
	}

if [[ ($CHZS -ge '1') && (($WUG = 'w') || ($EUG = 'e')) ]]; then
        Scan
else
        clear
        language_strings ${language} 12 "red"
        sleep 4;
        clear
        connect_info

fi
        ;;
        [yY] )
            clear
            sleep .5;
            connect_info
            ;;
        [cC] )
            clear
            pfile_clear
            exit
            ;;
	esac
}

connect_fail() {
    language_strings ${language} 0 "red"
    CHZ=$(ifconfig -s | grep 'BMRU' | awk '{print $1}')
    AP=$(iwconfig $CHZ | grep 'Access Point' | awk '{print $4}')
    if [[ $AP = Not-Associated ]]; then
        language_strings ${language} 5 "red"
   fi
}
fping_kr() {
	clear
    	language_strings ${language} 6 "red"
    	sleep 3
    	clear
	DGTM=$(cat /etc/os-release | grep '^ID=' | awk -F= '{print $2}')
	if [[ $DGTM = 'arch' ]]; then
        	pacman -Sy fping bc ethtool hwinfo --noconfirm
        	sleep 2
        	clear
	elif [[ $DGTM = 'ubuntu' ]]; then
        	sudo apt install fping bc ethtool hwinfo curl
        	sleep 2
        	clear
	elif [[ $DGTM = 'manjaro' ]]; then
        	pacman -Sy fping bc ethtool hwinfo --noconfirm
        	sleep 2
        	clear
	else
         	language_strings ${language} 7 "red"
    	sleep 10
    fi
    clear
	if [ -x /usr/bin/fping ] && [ -x /usr/bin/bc ] && [[ ((-x /usr/bin/ethtool) || (-x /sbin/ethtool)) ]]; then
        connect_info
    else
        clear
	    language_strings ${language} 8 "red"
	sleep 2;
	exit
	fi
}
    if [ -x /usr/bin/fping ] && [ -x /usr/bin/bc ] && [[ ((-x /usr/bin/ethtool) || (-x /sbin/ethtool)) ]]; then
        echo ""
    else
        fping_kr
    fi

BMR=$(ifconfig -s | awk '/BMU|BMRU/{print $1}' | awk 'END {print NR}')
if [[ $BMR -ge '1' ]]; then
    connect_info
else
    connect_fail
fi
}
set_chipset() {

	chipset=""
	sedrule1="s/^....//"
	sedrule2="s/ Network Connection//g"
	sedrule3="s/ Wireless Adapter//"
	sedrule4="s/Wireless LAN Controller //g"
	sedrule5="s/ Wireless Adapter//"
	sedrule6="s/^ //"
	sedrule7="s/ Gigabit Ethernet.*//"
	sedrule8="s/ Fast Ethernet.*//"
	sedrule9="s/ \[.*//"
	sedrule10="s/ (.*//"

	sedrulewifi="$sedrule1;$sedrule2;$sedrule3;$sedrule6"
	sedrulegeneric="$sedrule4;$sedrule2;$sedrule5;$sedrule6;$sedrule7;$sedrule8;$sedrule9;$sedrule10"
	sedruleall="$sedrule1;$sedrule2;$sedrule3;$sedrule6;$sedrule7;$sedrule8;$sedrule9;$sedrule10"

	if [ -f /sys/class/net/${1}/device/modalias ]; then

		bus_type=$(cat /sys/class/net/${1}/device/modalias | cut -d ":" -f 1)

		if [ "$bus_type" = "usb" ]; then
			vendor_and_device=$(cat /sys/class/net/${1}/device/modalias | cut -d ":" -f 2 | cut -b 1-10 | sed 's/^.//;s/p/:/')
			chipset=$(lsusb | grep -i "$vendor_and_device" | head -n1 - | cut -f3- -d ":" | sed "$sedrulewifi")

		elif [[ "$bus_type" =~ pci|ssb|bcma|pcmcia ]]; then

			if [[ -f /sys/class/net/${1}/device/vendor && -f /sys/class/net/${1}/device/device ]]; then
				vendor_and_device=$(cat /sys/class/net/${1}/device/vendor):$(cat /sys/class/net/${1}/device/device)
				chipset=$(lspci -d ${vendor_and_device} | cut -f3- -d ":" | sed "$sedrulegeneric")
			else
				if hash ethtool 2> /dev/null; then
					ethtool_output="$(ethtool -i ${1} 2>&1)"
					vendor_and_device=$(printf "$ethtool_output" | grep bus-info | cut -d ":" -f "3-" | sed 's/^ //')
					chipset=$(lspci | grep "$vendor_and_device" | head -n1 - | cut -f3- -d ":" | sed "$sedrulegeneric")
				fi
			fi
		fi
	elif [[ -f /sys/class/net/${1}/device/idVendor && -f /sys/class/net/${1}/device/idProduct ]]; then
		vendor_and_device=$(cat /sys/class/net/${1}/device/idVendor):$(cat /sys/class/net/${1}/device/idProduct)
		chipset=$(lsusb | grep -i "$vendor_and_device" | head -n1 - | cut -f3- -d ":" | sed "$sedruleall")
	fi
}
wifi_chipset() {
	ifaces=`ip link | egrep "^[0-9]+" | cut -d ':' -f 2 | awk {'print $1'} | grep lo -v|sed -n 2p`
	for item in ${ifaces}; do
		set_chipset ${item}
		if [ "$chipset" = "" ]; then
			echo -en "${red_color}${err[$language,14]}${normal_color}"
		else
			echo -e "\n\n${magenta_color} ${g_texts[$language,10]}${yellow_color}$chipset"
		fi
	done

}
eth_chipset() {
        ifaces=`ip link | egrep "^[0-9]+" | cut -d ':' -f 2 | awk {'print $1'} | grep lo -v|sed -n 1p`
        for item in ${ifaces}; do
                set_chipset ${item}
                if [ "$chipset" = "" ]; then
			echo -en "${red_color}${err[$language,14]}${normal_color}"
                else
                        echo -e "\n\n${magenta_color} ${g_texts[$language,10]}${yellow_color}$chipset"
                fi
        done

}
pconf_control() {
            PFILE="/tmp/passw"
            if [ -f $PFILE ];then
            conf_create
            else
            language_strings ${language} 16
            read -s -p "$(echo -e ${red_color}${b_texts[$language,19]}${normal_color})" passw
            echo $passw > $PFILE
            conf_create
        fi
}
conf_create() {
        eval LIST=( $(cat $PFILE |sudo -S iwlist $iface scan 2>/dev/null | awk -F":" '/ESSID/{print $2}') )
		if [ -z "${LIST[0]}" ]; then
			echo -e "${blue_color}${b_texts[$language,14]}${normal_color}"
			sleep 1
			Options
		fi
	echo -e "\n\n${red_color}${b_texts[$language,15]}${normal_color}"
	PS3=$'\n\033[01;33mNo: \033[0m'
	select ITEM in "${LIST[@]}"; do

		if [ -z "$ITEM" ] ; then
				wifiScan
		fi

		echo
		language_strings ${language} 36 "read"

		FILENAME=/tmp/$ITEM".wifi"

		wpa_passphrase "$ITEM" "$read" > "$FILENAME" | xargs
		wconnect $ITEM
	done
}
wconnect() {
	iface=`ip link | egrep "^[0-9]+" | cut -d ':' -f 2 | awk {'print $1'} | grep lo -v|sed -n 2p`
	ESSID=$*
        if [[ $(which nmcli 2>/dev/null) != "" ]]; then
                nmcli dev wifi connect $ESSID password $read ifname $iface
		sleep 2
		nohup ping -q -c3 -w3 www.google.com >/dev/null 2>&1
		if [[ $? -eq 0 ]];then
			echo -e " ${yellow_color}${b_texts[$language,17]}${normal_color}"
			sleep 1
		else
			echo -e " ${red_color}${b_texts[$language,18]}${normal_color}"
			sleep 1
		fi
        else
	        cat $PFILE |sudo -S  kill $(ps aux | grep -E '[w]pa_supplicant.*\'$iface'' |  awk '{print $2}') 2>/dev/null | xargs
	        cat $PFILE |sudo -S  dhclient $iface -r
	        cat $PFILE |sudo -S  ifconfig $iface down
	        cat $PFILE |sudo -S  iwconfig $iface mode managed essid "$ESSID"
	        cat $PFILE |sudo -S  ifconfig $iface up
	        cat $PFILE |sudo -S  nohup wpa_supplicant -B -Dwext -i$iface -c$FILENAME >/dev/null 2>&1 | xargs
	secs=15
	while [ $secs -gt 0 ];do
		echo -ne " ${yellow_color}${b_texts[$language,16]}${normal_color} $secs\033[0K\r"
	sleep 1
		: $((secs--))
	done
	cat $PFILE |sudo -S dhclient $iface

	ifconfig $iface | grep inet
	        nohup ping -q -c3 -w3 www.google.com >/dev/null 2>&1
                if [[ $? -eq 0 ]];then
			echo -e " ${yellow_color}${b_texts[$language,17]}${normal_color}"
                        sleep 1
                else
			echo -e " ${red_color}${b_texts[$language,18]}${normal_color}"
                        sleep 1
                fi
	fi
wifiScan
}
trap pfile_clear TERM EXIT KILL
main
