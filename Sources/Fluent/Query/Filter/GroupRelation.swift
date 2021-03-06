/// Possible relations between items in a group
public enum QueryGroupRelation {
    case and, or
}

extension QueryBuilder {
    public typealias GroupClosure = (QueryBuilder<Model>) throws -> ()

    /// Create a query group.
    @discardableResult
    public func group(
        _ relation: QueryGroupRelation,
        closure: @escaping GroupClosure
    ) rethrows -> Self {
        let sub = copy()
        try closure(sub)
        let filter = QueryFilter(
            entity: Model.entity,
            method: .group(relation, sub.query.filters)
        )
        return addFilter(filter)
    }
}
