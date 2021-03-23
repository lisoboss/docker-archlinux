# 更换国内源
cat >> /etc/pacman.conf <<EOF
[archlinuxcn]
Server = http://mirrors.163.com/archlinux/$repo/os/$arch
Server = http://mirrors.aliyun.com/archlinux/$repo/os/$arch
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch
SigLevel = Never
EOF

# 修复 not found GLIBC_2.33
patched_glibc=glibc-linux4-2.33-4-x86_64.pkg.tar.zst
curl -LO https://repo.archlinuxcn.org/x86_64/$patched_glibc
bsdtar -C / -xvf $patched_glibc
sed -r -i 's/^#?IgnorePkg\s*=\s*(.*)/IgnorePkg = \1 glibc/' /etc/pacman.conf

pacman -Syu --noconfirm
