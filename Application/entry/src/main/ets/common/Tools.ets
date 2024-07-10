class Tools {
  getResourceString(res: Resource): string {
    return getContext().resourceManager.getStringSync(res);
  }
}

export default new Tools();