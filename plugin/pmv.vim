command! -nargs=0 PmvAppendRelease call pmv#appendRelease()
nnoremap <plug>(pmv-append-release) :<c-u>PmvAppendRelease<cr>

command! -nargs=0 PmvLastRelease call pmv#lastRelease()
nnoremap <plug>(pmv-last-release) :<c-u>PmvLastRelease<cr>

command! -nargs=? PmvAllReleases call pmv#allReleases(<q-args>)
nnoremap <plug>(pmv-all-releases) :<c-u>PmvAllReleases<cr>

command! -nargs=? PmvAllVersions call pmv#allReleases(<q-args>)
nnoremap <plug>(pmv-all-versions) :<c-u>PmvAllVersions<cr>

command! -nargs=? PmvPackageInfo call pmv#packageInfo(<q-args>)
nnoremap <plug>(pmv-package-info) :<c-u>PmvPackageInfo<cr>

command! -nargs=? PmvOpenDocs call pmv#openDocs(<q-args>)
nnoremap <plug>(pmv-open-docs) :<c-u>PmvOpenDocs<cr>

command! -nargs=? PmvOpenRepoPage call pmv#openRepoPage(<q-args>)
nnoremap <plug>(pmv-open-repo-page) :<c-u>PmvOpenRepoPage<cr>
