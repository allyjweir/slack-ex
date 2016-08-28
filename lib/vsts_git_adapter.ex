defmodule vsts_git do

    @auth = [basic_auth: {"" : "lj4p53dmfkbrkvwbnrhqkt7uzah6joxxyfkudflsig6iflqdkpoa"}]

    def get_repos() do
        HTTPoison.start
        HTTPoison.get!("https://simul8.visualstudio.com/DefaultCollection/_apis/git/repositories?api-version=1.0", [], @auth)
        repo_details = strip_repo_data(Poison.Decode(HTTPoison.Response))
    end

    defp strip_repo_data(repos) do
        return Enum.map(repos, fn(x["value"]) -> [x["id"], x["name"]])
    end

    def get_pull_requests(repo_id) do
        HTTPoison.start
        HTTPoison.get!("https://simul8.visualstudio.com/DefaultCollection/_apis/git/repositories/#{:repo_id}/pullRequests?api-version=1.0-preview.1")
        old_prs = get_old_prs(Posion.Decode(HTTPoison.Response), 5)
    end

end
