
echo '开始部署到Github'
git push  && git checkout master && git merge dev && git push && hexo g -d && echo '开始进行部署blog到gitee' && git checkout gitee && git merge master && git push && hexo g -d && git checkout master && echo '批处理结束'