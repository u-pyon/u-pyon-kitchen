module RecipeHelper
  def plugin_instll_dir(plugin)
    File.join(node[:vim][:dir], ".vim", node[:vim][plugin.to_sym][:dir])
  end

  def plugin_path(plugin)
    File.join(node[:vim][:dir], ".vim", node[:vim][plugin.to_sym][:dir], plugin + '.vim')
  end
end
