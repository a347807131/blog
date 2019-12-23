echo '开始部署到Github'
git push && hexo g && hexo d && echo '开始进行部署blog到gitee' && git checkout gitee && git merge master && git push && hexo g && hexo d && git checkout master && echo '批处理结束'